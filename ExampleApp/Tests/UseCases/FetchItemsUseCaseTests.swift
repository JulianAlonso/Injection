@testable import App
import Foundation
import Injection
import Nimble
import XCTest

final class FetchItemsUseCaseTests: XCTestCase {

    func testFetchReturningServiceItems() {
        let mockService = TestItemService()
        let module = Module(parent: appModule) {
            factory { mockService as ItemService }
        }
        let mockItems = [Item(id: "0", name: "mock")]
        mockService.items = mockItems
        let sut = module.resolve() as FetchItemsUseCase

        let items = sut.execute()

        expect(items).to(equal(mockItems))
    }

}

private class TestItemService: ItemService {

    var items: [Item] = []

    func fetch() -> [Item] { items }
    func save(item: Item) -> Item { item }
}
