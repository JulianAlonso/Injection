import Foundation

final class FetchItemsUseCase: ItemUseCase {
    func execute() -> [Item] {
        service.fetch()
    }
}
