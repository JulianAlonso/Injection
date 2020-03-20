import SwiftUI

struct ItemListState: ViewState {
    var items: [Item]

    static var initial: ItemListState { ItemListState(items: []) }
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
            ItemView(item: item).onTapGesture { self.viewModel.handle(action: .selected(item)) }
        }
        .onAppear { delay(.seconds(1)) { self.viewModel.handle(action: .load) } }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
