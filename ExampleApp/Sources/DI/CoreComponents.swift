import Foundation
import Injection

let serviceComponent = Component {
    single { FakeItemService() as ItemService }
}

let useCaseComponent = Component {
    factory { FetchItemsUseCase(service: $0.resolve()) }
    factory { ToggleItemUseCase(service: $0.resolve()) }
}
