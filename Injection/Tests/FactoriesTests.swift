import Foundation
@testable import Injection
import Nimble
import XCTest

final class FactoriesTests: XCTestCase {

    private let module = Module { factory { A() } }

    func testInstanceFactoryBuilds() {
        let factory = InstanceFactory { _ in A() }

        expect(factory.build(self.module)).to(beAKindOf(A.self))
    }

    func testSingletonFactoryBuilds() {
        let factory = SingletonFactory { _ in B() }

        expect(factory.build(self.module)).to(beAKindOf(B.self))
    }

    func testSingletonFactorySameInstance() {
        let factory = SingletonFactory { _ in B() }

        expect(factory.build(self.module)).to(beIdenticalTo(factory.build(module)))
    }

}

private struct A {}
private class B {}
