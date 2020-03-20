import SwiftUI

struct ItemListState {
    var items: [Item]
}

enum ItemListAction {
    case selected(Item)
}

struct ItemListView: View {

    @EnvironmentObject
    var viewModel: AnyViewModel<ItemListState, ItemListAction>

    var body: some View {
        List(viewModel.state.items) { item in
            ItemView(item: item)
                .onTapGesture { self.viewModel.handle(action: .selected(item)) }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
