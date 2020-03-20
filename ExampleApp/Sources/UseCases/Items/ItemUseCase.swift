import Foundation

class ItemUseCase {
    let service: ItemService

    init(service: ItemService) {
        self.service = service
    }
}
