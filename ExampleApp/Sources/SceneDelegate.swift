import Injection
import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let navigator = Navigator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        injectMe {
            component { serviceComponent }
            component { useCaseComponent }
            factory { self.navigator }
        }

        if let windowScene = scene as? UIWindowScene {
            window = navigator.setup(window: UIWindow(windowScene: windowScene))
            window?.makeKeyAndVisible()
            navigator.handle(navigation: .push(.list()))
        }
    }

}
