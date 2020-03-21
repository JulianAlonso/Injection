import SwiftUI

struct ItemCellView: View {
    let item: Item

    var body: some View {
        HStack {
            Text(item.name).headline
            Spacer()
            Image("arrow")
        }
    }
}
