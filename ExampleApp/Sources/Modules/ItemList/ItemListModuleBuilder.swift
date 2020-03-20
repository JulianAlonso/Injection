import Foundation
import Injection
import SwiftUI
import UIKit

final class ItemListModuleBuilder: ModuleBuilder {

    override func component() -> Component? {
        Component {
            factory { ItemListViewModel(fetchItemsUseCase: $0.resolve()) }
        }
    }

    override func build() -> UIViewController {
        UIHostingController(rootView: ItemListView().environmentObject((module.resolve() as ItemListViewModel).any))
    }

}

extension Screen {
    static func first() -> Self {
        .init() { ItemListModuleBuilder().build() }
    }
}
