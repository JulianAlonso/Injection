import Foundation
import Injection

let storageComponent = Component {
    factory { UserDefaults.standard as Storage }
}

let serviceComponent = Component {
    single { LocalItemService(storage: $0()) as ItemService }
}

let useCaseComponent = Component {
    factory { FetchItemsUseCase(service: $0()) }
    factory { ToggleItemUseCase(service: $0()) }
}
