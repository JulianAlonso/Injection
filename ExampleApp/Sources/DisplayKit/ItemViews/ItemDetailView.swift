import Foundation
import SwiftUI

struct ItemDetailState: ViewState {
    var item: Item

    static var initial: ItemDetailState { fatalError("Not supported inital on ItemDetailState") }
}

enum ItemDetailAction {
    case toggle(Item)
}

struct ItemDetailView: View {

    @EnvironmentObject
    var viewModel: AnyViewModel<ItemDetailState, ItemDetailAction>

    var body: some View {
        VStack {
            Text(viewModel.state.item.name).primary
            Button(action: { self.viewModel.handle(action: .toggle(self.viewModel.state.item)) }) {
                Text(viewModel.state.item.isFavorite ? "Unvaforite" : "Favorite").action
            }
        }
    }

}
