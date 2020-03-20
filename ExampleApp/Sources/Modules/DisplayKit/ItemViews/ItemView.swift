import SwiftUI

struct ItemView: View {
    let item: Item

    var body: some View {
        Text(item.name).headline
    }
}
