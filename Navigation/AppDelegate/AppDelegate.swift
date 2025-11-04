//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    
    var window: UIWindow?
    var appCoordinator: TabBarCoordinator?
    let localNotificationService = LocalNotificationService()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootNavigationController = UINavigationController()

        appCoordinator = TabBarCoordinator(navigationController: rootNavigationController)
        
        // activate main window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        appCoordinator?.start()
        
        localNotificationService.registerForLatestUptadatesIfPossible()
        
        return true
    }
}

