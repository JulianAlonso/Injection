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

        let bone: B = module.resolve()
        let btwo: B = module.resolve()

        expect(bone).to(beIdenticalTo(btwo))
    }

    func testResolveWeak() {
        let module = Module {
            weak { B() }
        }

        let bone: B = module.resolve()
        let btwo: B = module.resolve()

        expect(bone).to(beIdenticalTo(btwo))
    }

    func testResolveWithParent() {
        let parent = Module {
            factory { A() }
        }
        let child = Module(parent: parent) {
            factory { C(a: $0()) }
        }

        expect { _ = child.resolve() as C }.toNot(throwAssertion())
    }

    func testResolveExpanded() {
        let component = Component {
            factory { C(a: $0()) }
        }
        let module = Module {
            factory { A() }
        }.expand(with: component)

        expect { _ = module.resolve() as C }.toNot(throwAssertion())
    }

    func testSharedResolveFunction() {
        let module = Module {
            factory { A() }
        }
        injectMe(module)

        expect { _ = resolve() as A }.toNot(throwAssertion())

        Injection.reset()
    }

}

private struct A {}
private class B {}
private struct C {
    let a: A
}
