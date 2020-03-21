import Foundation

final class ToggleItemUseCase: ItemUseCase {

    func execute(toogle item: Item) -> Item {
        service.toggle(item: item)
    }

}
