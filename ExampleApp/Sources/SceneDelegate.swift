import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let navigator = Navigator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = navigator.setup(window: UIWindow(windowScene: windowScene))
            window?.makeKeyAndVisible()
            navigator.handle(navigation: .push(.first()))
        }
    }

}

extension Screen {
    static func first() -> Self {
        .init() { UIHostingController(rootView: ItemListView().environmentObject(ItemListViewModel().any)) }
    }
}
