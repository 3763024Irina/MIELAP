import UIKit
import OpenAPIClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        OpenAPIClientAPI.basePath = "https://miel.sayrrx.cfd"
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
            print("Токен в AppDelegate установлен:", token)
        }
        
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
