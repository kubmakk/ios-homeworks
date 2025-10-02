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

        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        let loginCoordinator = LoginCoordinator(navigationController: profileNavigationController)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)

        addChild(feedCoordinator)
        addChild(loginCoordinator)
        addChild(favoritesCoordinator)

        feedCoordinator.start()
        loginCoordinator.start()
        favoritesCoordinator.start()

        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController, favoritesNavigationController]

        rootNavigationController.setViewControllers([tabBarController], animated: false)
        rootNavigationController.isNavigationBarHidden = true 
    }
}
