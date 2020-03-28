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
