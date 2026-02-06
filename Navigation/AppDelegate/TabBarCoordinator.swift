//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 31.03.2025.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    let tabBarController = UITabBarController()
    let rootNavigationController: UINavigationController

    override init(navigationController: UINavigationController) {
        self.rootNavigationController = navigationController
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let feedNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        let favoritesNavigationController = UINavigationController()
        let mapNavigationController = UINavigationController()

        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        let loginCoordinator = LoginCoordinator(navigationController: profileNavigationController)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
        let mapCoordinator = MapCoordinator(navigationController: mapNavigationController)

        addChild(feedCoordinator)
        addChild(loginCoordinator)
        addChild(favoritesCoordinator)
        addChild(mapCoordinator)

        feedCoordinator.start()
        loginCoordinator.start()
        favoritesCoordinator.start()
        mapCoordinator.start()

        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        mapNavigationController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 3)

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController, favoritesNavigationController, mapNavigationController]

        rootNavigationController.setViewControllers([tabBarController], animated: false)
        rootNavigationController.isNavigationBarHidden = true 
    }
}
