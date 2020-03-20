import SwiftUI
import UIKit

enum Navigation {
    case push(Screen)
}

struct Screen {
    let viewController: () -> UIViewController
}

final class Navigator {
    var navigationController: UINavigationController {
        UIApplication.shared.windows.first?.rootViewController as! UINavigationController
    }

    func handle(navigation: Navigation, animated: Bool = true) {
        switch navigation {
        case .push(let screen):
            navigationController.pushViewController(
                screen.viewController(),
                animated: animated
            )
        }
    }

}

extension Navigator {
    func setup(window: UIWindow) -> UIWindow {
        window.rootViewController = UINavigationController()
        return window
    }
}
