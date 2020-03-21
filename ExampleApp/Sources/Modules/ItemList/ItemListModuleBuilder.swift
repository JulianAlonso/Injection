import Foundation
import Injection
import SwiftUI
import UIKit

final class ItemListModuleBuilder: ModuleBuilder {

    override func component() -> Component? {
        Component {
            factory { ItemListViewModel(navigator: $0.resolve(), fetchItemsUseCase: $0.resolve()) }
        }
    }

    override func build() -> UIViewController {
        UIHostingController(rootView: ItemListView().environmentObject((module.resolve() as ItemListViewModel).any))
    }

}

extension Screen {
    static func list() -> Self {
        .init() { ItemListModuleBuilder().build() }
    }
}
