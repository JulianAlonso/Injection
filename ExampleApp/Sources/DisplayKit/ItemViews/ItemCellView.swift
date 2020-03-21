import SwiftUI

struct ItemCellView: View {
    let item: Item

    var body: some View {
        HStack {
            item.favoriteImage
            Text(item.name).headline
            Spacer()
            Image("arrow")
        }
    }
}

extension Item {
    var favoriteImage: Image { isFavorite ? Image("star") : Image("unstar") }
}
