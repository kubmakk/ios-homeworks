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
        let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
        
        feedCoordinator.start()
        loginCoordinator.start()
        
        tabBarController.viewControllers = [feedCoordinator.navigationController, loginCoordinator.navigationController]
        
        feedCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        loginCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    
}
