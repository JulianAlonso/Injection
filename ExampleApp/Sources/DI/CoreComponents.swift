import Foundation
import Injection

let storageComponent = Component {
    factory { UserDefaults.standard as Storage }
}

let serviceComponent = Component {
    factory { LocalItemService(storage: $0.resolve()) as ItemService }
}

let useCaseComponent = Component {
    factory { FetchItemsUseCase(service: $0.resolve()) }
    factory { ToggleItemUseCase(service: $0.resolve()) }
}
