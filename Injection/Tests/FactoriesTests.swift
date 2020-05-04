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

    func testWeakFactorySameInstance() {
        let factory = WeakFactory { _ in B() }

        let bone = factory.build(module)
        let btwo = factory.build(module)

        expect(bone).to(beIdenticalTo(btwo))
    }

    func testWeakFactoryDeletesInstance() {
        let factory = WeakFactory { _ in B() }
        var oneAddress: String?
        var twoAddress: String?

        var bone: B? = factory.build(module) as? B
        withUnsafePointer(to: &bone) {
            oneAddress = "\($0)"
        }
        bone = nil

        var btwo: B? = factory.build(module) as? B
        withUnsafePointer(to: &btwo) {
            twoAddress = "\($0)"
        }

        expect(oneAddress).toNot(equal(twoAddress))
    }

}

private struct A {}
private class B {}
