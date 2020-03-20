import Foundation
@testable import Injection
import Nimble
import XCTest

final class ModuleBuilderTests: XCTestCase {

    override func tearDown() {
        Injection.reset()
    }

    func testModuleBuilderWithoutComponent() {
        let module = Module { factory { A() } }
        Injection.initialize(with: module)

        expect { _ = TestBuilder().build() }.toNot(throwAssertion())
    }

    func testModuleBuilderWithComponent() {
        let module = Module { factory { C() } }
        let component = Component { factory { A() } }
        Injection.initialize(with: module)

        expect { _ = TestBuilder(component).build() }.toNot(throwAssertion())
    }

}

private struct A {}
private struct B {
    let a: A
}

private struct C {}

private final class TestBuilder: ModuleBuilder<B> {

    private let _component: Component?

    init(_ component: Component? = nil) {
        self._component = component
    }

    override func component() -> Component? { _component }

    override func build() -> B {
        B(a: module.resolve())
    }
}
