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
        window?.makeKeyAndVisible()

        // create TabBarController
        let tabBarController = UITabBarController()
        
        // create ViewContrillers with Title with color
        let loginVC = LogInViewController()
        loginVC.title = "Profile"
        let feedVC = FeedViewController()
        feedVC.title = "Feed"
        feedVC.view.backgroundColor = .yellow
        
        //create NavigationVIewController with root with tabBarItem
        let profileNavigationVC = UINavigationController(rootViewController: loginVC)
        profileNavigationVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "star"), tag: 0)
        profileNavigationVC.navigationBar.backgroundColor = .white

        let feedNavigationVC = UINavigationController(rootViewController: feedVC)
        feedNavigationVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "airplane"), tag: 0)

        tabBarController.viewControllers = [profileNavigationVC, feedNavigationVC]
        window?.rootViewController = tabBarController
        
        
        return true
    }
}

