import Foundation

final class ToggleItemUseCase: ItemUseCase {

    func execute(toogle item: Item) -> Item {
        service.save(item: item.toggled)
    }

}
