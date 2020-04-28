import Foundation
@testable import Injection
import Nimble
import XCTest

final class InjectPropertyWrapperTests: XCTestCase {

    let module = Module {
        factory { Service(name: "A") }
        factory(tag: "B") { Service(name: "B") }
        factory { Injected() }
        factory { Lazy() }
        factory { InjectedB() }
        factory { LazyB() }
    }

    override func tearDown() {
        super.tearDown()
        Injection.reset()
    }

    func testInjectPropertyWrapper() {
        Injection.initialize(with: module)

        expect { _ = resolve() as Injected }.toNot(throwAssertion())
    }

    func testLazyInjectPropertyWrapper() {
        Injection.initialize(with: module)

        expect { _ = resolve() as Lazy }.toNot(throwAssertion())
    }

    func testInjectPropertyWrapperWithTag() {
        Injection.initialize(with: module)

        let injected = resolve() as InjectedB

        expect(injected.service.name).to(equal("B"))
    }

    func testLazyInjectPropertyWrapperWithTag() {
        Injection.initialize(with: module)

        let injected = resolve() as LazyB

        expect(injected.service.name).to(equal("B"))
    }

}

private struct Service {
    let name: String

    init(name: String) {
        self.name = name
    }
}

private class Injected {
    @Inject var service: Service
}

private class Lazy {
    @LazyInject var service: Service
}

private class InjectedB {
    @Inject(tag: "B") var service: Service
}

private class LazyB {
    @LazyInject(tag: "B") var service: Service
}
