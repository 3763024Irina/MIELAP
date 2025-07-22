import UIKit
import OpenAPIClient
import AnyCodable
final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mielPink = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)

        let showcaseVC = CandidatesViewController()
        let favoritesVC = FavoritesViewController()
        let invitationsVC = InvitationsViewController()
        let quotasVC = QuotasViewController()

        // Твои иконки
        let showcaseItem = UITabBarItem(title: "", image: UIImage(named: "Vitrin"), tag: 0)
        showcaseItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let favoritesItem = UITabBarItem(title: "", image: UIImage(named: "Heart"), tag: 1)
        favoritesItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let invitationsItem = UITabBarItem(title: "", image: UIImage(named: "Cart"), tag: 2)
        invitationsItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let quotasItem = UITabBarItem(title: "", image: UIImage(named: "Quots"), tag: 3)
        quotasItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        showcaseVC.tabBarItem = showcaseItem
        favoritesVC.tabBarItem = favoritesItem
        invitationsVC.tabBarItem = invitationsItem
        quotasVC.tabBarItem = quotasItem

        viewControllers = [
            UINavigationController(rootViewController: showcaseVC),
            UINavigationController(rootViewController: favoritesVC),
            UINavigationController(rootViewController: invitationsVC),
            UINavigationController(rootViewController: quotasVC)
        ]

        // Цвета таб-бара
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = mielPink
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.7)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
