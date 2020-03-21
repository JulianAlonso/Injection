@testable import App
import Foundation
import Injection
import Nimble
import XCTest

final class LocalItemServiceTests: XCTestCase {

    func testSave() {
        let mockStorage = TestStorage()
        let module = Module(parent: appModule) {
            factory { mockStorage as Storage }
        }

        let sut = module.resolve() as ItemService

        _ = sut.save(item: Item(id: "0", name: "name"))

        expect(mockStorage.dic.count).to(equal(1))
    }

    func testFetch() {
        let mockStorage = TestStorage()
        let module = Module(parent: appModule) {
            factory { mockStorage as Storage }
        }

        let sut = module.resolve() as ItemService

        let items = sut.fetch()

        expect(items.count).to(equal(5))
    }

}

private enum Test: String {
    case test
}

private class TestStorage: Storage {

    var dic: [String: Any] = [:]

    func set<K, T>(key: K, value: T?) where K: RawRepresentable, K.RawValue == String {
        dic[key.rawValue] = value
    }

    func get<K, T>(key: K) -> T? where K: RawRepresentable, K.RawValue == String {
        dic[key.rawValue] as? T
    }

    func get<K, T>(key: K, default: T) -> T where K: RawRepresentable, K.RawValue == String {
        get(key: key) ?? `default`
    }

}
