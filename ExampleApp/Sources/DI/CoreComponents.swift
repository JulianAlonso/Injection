import Foundation
import Injection

let serviceComponent = Component {
    factory { FakeItemService() as ItemService }
}

let useCaseComponent = Component {
    factory { FetchItemsUseCase(service: $0.resolve()) }
}
