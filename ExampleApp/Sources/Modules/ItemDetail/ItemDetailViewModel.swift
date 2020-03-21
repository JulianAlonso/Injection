import Foundation

final class ItemDetailViewModel: ViewModel {

    @Published private(set) var state: ItemDetailState

    private let toggleItemUseCase: ToggleItemUseCase

    init(item: Item, toggleItemUseCase: ToggleItemUseCase) {
        self.state = ItemDetailState(item: item)
        self.toggleItemUseCase = toggleItemUseCase
    }

    func handle(action: ItemDetailAction) {
        switch action {
        case .toggle(let item):
            state.item = toggleItemUseCase.execute(toogle: item)
        }
    }

}
