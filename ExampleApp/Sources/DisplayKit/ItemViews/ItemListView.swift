import SwiftUI
import UIKit

struct ItemListState: ViewState {
    var items: [Item] = []

    static var initial: ItemListState { ItemListState() }
}

enum ItemListAction {
    case load
    case selected(Item)
}

struct ItemListView: View {

    @EnvironmentObject
    var viewModel: AnyViewModel<ItemListState, ItemListAction>

    var body: some View {
        List(viewModel.state.items) { item in
            ItemCellView(item: item).onTapGesture { self.viewModel.handle(action: .selected(item)) }
        }
        .listStyle(GroupedListStyle())
        .onAppear { async { self.viewModel.handle(action: .load) } }
    }

}
