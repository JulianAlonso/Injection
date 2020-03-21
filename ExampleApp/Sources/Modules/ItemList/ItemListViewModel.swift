import Foundation

final class ItemListViewModel: ViewModel {

    @Published private(set) var state: ItemListState = .initial

    private let navigator: Navigator
    private let fetchItemsUseCase: FetchItemsUseCase

    init(navigator: Navigator, fetchItemsUseCase: FetchItemsUseCase) {
        self.navigator = navigator
        self.fetchItemsUseCase = fetchItemsUseCase
    }

    func handle(action: ItemListAction) {
        switch action {
        case .load: state.items = fetchItemsUseCase.execute()
        case .selected(let item): navigator.handle(navigation: .push(.detail(item: item)))
        }
    }

}
