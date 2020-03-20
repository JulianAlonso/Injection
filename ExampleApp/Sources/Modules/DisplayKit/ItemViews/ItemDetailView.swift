import SwiftUI

struct ItemDetailState: ViewState {
    let item: Item

    static var initial: ItemDetailState { fatalError("Not supported inital on ItemDetailState") }
}

struct ItemDetailView: View {

    @EnvironmentObject
    var viewModel: AnyViewModel<ItemDetailState, Never>

    var body: some View {
        Text(viewModel.state.item.name).primary
    }

}
