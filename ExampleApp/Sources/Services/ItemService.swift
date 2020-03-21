import Foundation

protocol ItemService {
    func fetch() -> [Item]
    func save(item: Item) -> Item
}
