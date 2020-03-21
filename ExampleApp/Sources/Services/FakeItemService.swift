import Foundation

final class FakeItemService: ItemService {

    private let storage: Storage

    init(storage: Storage) {
        self.storage = storage
    }

    func fetch() -> [Item] { generate() }

    func toggle(item: Item) -> Item {
        save(item.toggled)
    }

    private func save(_ item: Item) -> Item {
        storage.set(key: item, value: item.isFavorite)
        return item
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
        ].map { Item(id: $0.id, name: $0.name, favorite: storage.get(key: $0, default: false)) }
    }

}
