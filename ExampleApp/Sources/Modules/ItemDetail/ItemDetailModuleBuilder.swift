import Foundation
import Injection
import SwiftUI
import UIKit

final class ItemDetailModuleBuilder: ModuleBuilder {

    private let item: Item

    init(item: Item) {
        self.item = item
    }

    override func component() -> Component? {
        Component {
            factory { ItemDetailViewModel(item: self.item) }
        }
    }

    override func build() -> UIViewController {
        UIHostingController(rootView: ItemDetailView().environmentObject((module.resolve() as ItemDetailViewModel).any))
    }

}

extension Screen {
    static func detail(item: Item) -> Self {
        .init() { ItemDetailModuleBuilder(item: item).build() }
    }
}
