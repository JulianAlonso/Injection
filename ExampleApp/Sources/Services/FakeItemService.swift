import Foundation

final class FakeItemService: ItemService {
    private var items: [Item] = []

    init() {
        self.items = generate()
    }

    func fetch() -> [Item] { items }

    func toggle(item: Item) -> Item {
        let toggled = item.toggled
        if let index = items.firstIndex(of: item) {
            items[index] = toggled
        }
        return toggled
    }
}

private extension FakeItemService {

    func generate() -> [Item] {
        [
            Item(id: "0", name: "First"),
            Item(id: "1", name: "Second"),
            Item(id: "2", name: "Third"),
            Item(id: "3", name: "Fourth"),
            Item(id: "4", name: "Fifth")
        ]
    }

}
