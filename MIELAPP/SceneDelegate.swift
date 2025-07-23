import UIKit
import OpenAPIClient

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        showWelcome() // первый экран

        window?.makeKeyAndVisible()
    }

    private func showWelcome() {
        let welcomeVC = WelcomeViewController()
        window?.rootViewController = welcomeVC
        print("SceneDelegate: WelcomeViewController открыт")

        // Переход к логину через 1.2 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.showLogin()
        }
    }

    private func showLogin() {
        print("SceneDelegate: Показываю LoginViewController")
        let loginVC = LoginViewController()
        loginVC.completion = { [weak self] in
            self?.showGreeting()
        }
        window?.setRootViewController(loginVC)
    }

    private func showGreeting() {
        print("SceneDelegate: Показываю GreetingViewController")
        let greetingVC = GreetingViewController()
        greetingVC.completion = { [weak self] in
            self?.showMainTabBar()
        }
        window?.setRootViewController(greetingVC)
    }

    private func showMainTabBar() {
        print("SceneDelegate: Показываю MainTabBarController")
        let mainTabBar = MainTabBarController()
        window?.setRootViewController(mainTabBar)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

// MARK: - Плавная замена rootViewController
extension UIWindow {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated else {
            rootViewController = vc
            makeKeyAndVisible()
            return
        }
        UIView.transition(with: self,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.rootViewController = vc
                          },
                          completion: nil)
    }
}
