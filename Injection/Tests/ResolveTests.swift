import Foundation
@testable import Injection
import Nimble
import XCTest

final class ResolveTests: XCTestCase {

    func testResolveFactory() {
        let module = Module {
            factory { A() }
        }

        expect { _ = module.resolve() as A }.toNot(throwAssertion())
    }

    func testResolveSingleton() {
        let module = Module {
            single { B() }
        }

        expect(module.resolve() as B).to(beIdenticalTo(module.resolve() as B))
    }

    func testResolveWithParent() {
        let parent = Module {
            factory { A() }
        }
        let child = Module(parent: parent) {
            factory { C(a: $0.resolve()) }
        }

        expect { _ = child.resolve() as C }.toNot(throwAssertion())
    }

    func testResolveExpanded() {
        let component = Component {
            factory { C(a: $0.resolve()) }
        }
        let module = Module {
            factory { A() }
        }.expand(with: component)

        expect { _ = module.resolve() as C }.toNot(throwAssertion())
    }

}

private struct A {}
private class B {}
private struct C {
    let a: A
}
