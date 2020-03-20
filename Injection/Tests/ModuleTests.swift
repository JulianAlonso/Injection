import Foundation
@testable import Injection
import Nimble
import XCTest

final class ModuleTests: XCTestCase {

    func testModuleInitSingleEntry() {
        let module = Module {
            factory { A() }
        }

        expect(module.factories.count).to(equal(1))
    }

    func testModuleInitManyEntries() {
        let module = Module {
            factory { A() }
            factory { B() }
        }

        expect(module.factories.count).to(equal(2))
    }

    func testModuleParentInit() {
        let parent = Module {
            factory { A() }
        }

        let module = Module(parent: parent) {
            factory { B() }
        }

        expect(module.parent).to(beIdenticalTo(parent))
    }

    func testModuleExpand() {
        let component = Component {
            factory { A() }
        }
        let module = Module {
            factory { B() }
        }

        let expanded = module.expand(with: component)

        expect(expanded.factories.count).to(equal(2))
    }

    func testModuleExpandedNilDontDoAnything() {
        let module = Module {
            factory { A() }
        }

        let expanded = module.expand(with: nil)

        expect(module).to(beIdenticalTo(expanded))
    }

}

private struct A {}
private struct B {}
