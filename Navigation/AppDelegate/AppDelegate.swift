//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    var appCoordinator: TabBarCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let loginFactory = MyLoginFactory()
        let loginInspector = loginFactory.makeLoginInspector()
        
        let loginVC = LoginViewController()
        loginVC.loginDelegate = loginInspector
        
        let navCoordinator = UINavigationController()
        
        appCoordinator = TabBarCoordinator(navigationController: navCoordinator)
        
        // activate main window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navCoordinator
        window?.makeKeyAndVisible()
        
        appCoordinator?.start()
        
        return true
    }
}

