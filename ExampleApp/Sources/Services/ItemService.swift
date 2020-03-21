import Foundation

protocol ItemService {
    func fetch() -> [Item]
    func toggle(item: Item) -> Item
}
