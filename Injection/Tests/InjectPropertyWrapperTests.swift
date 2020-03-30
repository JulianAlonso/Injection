import Foundation
@testable import Injection
import Nimble
import XCTest

final class InjectPropertyWrapperTests: XCTestCase {

    func testInjectedStruct() {
        let module = Module {
            factory { A() }
            factory { B(name: "Inject") }
        }

        let a: A = module.resolve()

        expect(a.b.name).to(equal("Inject"))
    }

    func testInjectedStructOnClass() {
        let module = Module {
            factory { CA() }
            factory { B(name: "Inject") }
        }
        let ca: CA = module.resolve()

        expect(ca.b.name).to(equal("Inject"))
    }

    func testInjectedWithInheritance() {
        let module = Module {
            factory { A() }
            factory { CB() }
            factory { B(name: "Inject") }
        }
        let cb: CB = module.resolve()

        expect(cb.b.name).to(equal("Inject"))
        expect(cb.a.b.name).to(equal("Inject"))
    }

    func testInjectOnModuleBuilder() {
        let module = Module {
            factory { B(name: "Inject") }
            factory { Built(b: $0.resolve()) }
        }
        Injection.initialize(with: module)

        let b = TestModuleBuilder().build()

        expect(b.name).to(equal("Inject"))
        Injection.reset()
    }

    func testInjectWithTag() {
        let module = Module {
            factory { ATag() }
            factory { B(name: "Inject") }
            factory(tag: "tag") { B(name: "tagged") }
        }

        let a = module.resolve() as ATag

        expect(a.b.name).to(equal("tagged"))
    }

}

private struct A {
    @Inject var b: B
}

private struct B {
    let name: String
}

private class CA {
    @Inject var b: B
}

private class CB: CA {
    @Inject var a: A
}

private struct Built {
    let b: B
}

private struct ATag {
    @Inject(tag: "tag") var b: B
}

private final class TestModuleBuilder: ModuleBuilder<B> {

    @Inject var built: Built

    override func build() -> B {
        built.b
    }

}
