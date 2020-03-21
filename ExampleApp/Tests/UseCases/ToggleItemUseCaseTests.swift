@testable import App
import Foundation
import Injection
import Nimble
import XCTest

final class ToggleItemUseCaseTests: XCTestCase {

    func testToggle() {
        let mockService = TestItemService()
        let module = Module(parent: appModule) {
            factory { mockService as ItemService }
        }

        let sut = module.resolve() as ToggleItemUseCase

        let item = sut.execute(toogle: Item(id: "0", name: "name"))

        expect(item.isFavorite).to(beTrue())
    }

}

private class TestItemService: ItemService {
    func fetch() -> [Item] { [] }
    func save(item: Item) -> Item { item }
}
