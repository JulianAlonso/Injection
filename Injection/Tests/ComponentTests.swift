import Foundation
@testable import Injection
import Nimble
import XCTest

final class ComponentTests: XCTestCase {

    func testComponentEntries() {
        let component = Component {
            factory { A() }
        }

        expect(component._entries.count).to(equal(1))
    }

    func testComponentRegistrationEntries() {
        let component = Component {
            factory { A() }
            factory { B() }
        }

        expect(component._entries).to(equal(component.entries()))
    }

}

private struct A {}
private struct B {}
