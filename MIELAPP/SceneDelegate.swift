import UIKit
import OpenAPIClient

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // 1. Welcome
        let welcomeVC = WelcomeViewController()
        window.rootViewController = welcomeVC
        window.makeKeyAndVisible()
        print("SceneDelegate: WelcomeViewController открыт")
        
        // 2. Login через 1.2 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            print("SceneDelegate: Показываю LoginViewController")
            let loginVC = LoginViewController()
            loginVC.completion = {
                print("SceneDelegate: Показываю GreetingViewController")
                let greetingVC = GreetingViewController()
                greetingVC.completion = {
                    print("SceneDelegate: Показываю MainTabBarController")
                    let mainTabBar = MainTabBarController()
                    window.setRootViewController(mainTabBar) // <--- вот тут!
                }
                window.setRootViewController(greetingVC)
            }
            window.setRootViewController(loginVC)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

// Extension — ставь вне класса SceneDelegate!
extension UIWindow {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated else {
            self.rootViewController = vc
            self.makeKeyAndVisible()
            return
        }
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.rootViewController = vc
        }, completion: nil)
    }
}
