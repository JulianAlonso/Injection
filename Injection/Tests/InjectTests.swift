import Foundation
@testable import Injection
import Nimble
import XCTest

final class InjectTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        Injection.reset()
    }

    func testInjectCrashIfNoModuleProvidedWhenCallModule() {
        expect { () -> Void in _ = Injection.module }.to(throwAssertion())
    }

    func testInjectCrashIfInitializeTwoTimes() {
        let module = Module { factory { A() } }
        expect { () -> Void in
            Injection.initialize(with: module)
            Injection.initialize(with: module)
        }.to(throwAssertion())
    }

    func testInjectModuleIsInitialized() {
        let module = Module { factory { A() } }
        Injection.initialize(with: module)

        expect(Injection.module).to(beIdenticalTo(module))
    }

    private struct A {}
}
