import UIKit
import OpenAPIClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureAPI()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // Установка базового URL и токена
    func configureAPI() {
        OpenAPIClientAPI.basePath = "https://miel.sayrrx.cfd"
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
            print("Токен установлен: \(token)")
        } else {
            OpenAPIClientAPI.customHeaders.removeValue(forKey: "Authorization")
            print("Токена нет")
        }
    }
}
