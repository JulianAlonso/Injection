import Foundation

final class ItemListViewModel: ViewModel {

    @Published private(set) var state: ItemListState = .initial

    private let fetchItemsUseCase: FetchItemsUseCase

    init(fetchItemsUseCase: FetchItemsUseCase) {
        self.fetchItemsUseCase = fetchItemsUseCase
    }

    func handle(action: ItemListAction) {
        switch action {
        case .load: state.items = fetchItemsUseCase.execute()
        case .selected: break
        }
    }

}
