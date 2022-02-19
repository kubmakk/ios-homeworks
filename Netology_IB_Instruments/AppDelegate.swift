//
//  AppDelegate.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 07.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.backgroundColor = .purple
        
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "star"), tag: 0)
        let feedItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "airplane"), tag: 1)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = profileItem
        profileVC.view.backgroundColor = .green
        
        let feedVC = FeedViewController()
        feedVC.tabBarItem = feedItem
        
        let profileNC = UINavigationController(rootViewController: profileVC)
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        
        tabBarController.viewControllers = [feedNC, profileNC]
        tabBarController.selectedIndex = 0
        
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

