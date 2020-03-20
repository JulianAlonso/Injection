import Foundation

final class ItemListViewModel: ViewModel {

    @Published private(set) var state: ItemListState

    init() {
        self.state = ItemListState(items: [])
    }

    func handle(action: ItemListAction) {}

}
