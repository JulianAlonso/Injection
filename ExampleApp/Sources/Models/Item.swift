import Foundation

struct Item: Identifiable, Hashable {
    let id: String
    let name: String
    let isFavorite: Bool

    init(id: String, name: String, favorite: Bool = false) {
        self.id = id
        self.name = name
        self.isFavorite = favorite
    }
}

extension Item {
    var toggled: Item {
        Item(id: id, name: name, favorite: !isFavorite)
    }
}
