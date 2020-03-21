import Foundation

final class ItemDetailViewModel: ViewModel {

    @Published private(set) var state: ItemDetailState

    init(item: Item) {
        self.state = ItemDetailState(item: item)
    }

    func handle(action: ItemDetailAction) {
        switch action {
        case .toggle(let item): print("Toogle: \(item)")
        }
    }

}
