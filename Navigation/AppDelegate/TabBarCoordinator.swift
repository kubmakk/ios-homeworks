//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 31.03.2025.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    let tabBarController = UITabBarController()
    
    override func start() {
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        
        feedCoordinator.start()
        profileCoordinator.start()
        
        tabBarController.viewControllers = [feedCoordinator.navigationController, profileCoordinator.navigationController]
        
        feedCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        profileCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    
}
