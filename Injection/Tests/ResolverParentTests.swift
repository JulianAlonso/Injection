import Foundation
import Injection
import Nimble
import XCTest

final class ResolverParentTests: XCTestCase {

    func testParentResolveParentDependencyWithChildInstance() {
        let parent = Module {
            factory { B(a: $0.resolve()) }
        }
        let child = Module(parent: parent) {
            factory { A(module: "Child") }
        }

        expect((child.resolve() as B).a.module).to(equal("Child"))
    }

    func testChildModuleHavePreferenceOverParents() {
        let grandParent = Module {
            factory { A(module: "GrandParent") }
            factory { B(a: $0.resolve()) }
        }
        let parent = Module(parent: grandParent) {
            factory { A(module: "Parent") }
        }
        let child = Module(parent: parent) {
            factory { A(module: "Child") }
        }

        expect((child.resolve() as B).a.module).to(equal("Child"))
        expect((parent.resolve() as B).a.module).to(equal("Parent"))
        expect((grandParent.resolve() as B).a.module).to(equal("GrandParent"))
    }

}

private struct A {
    let module: String
}

private struct B {
    let a: A
}
