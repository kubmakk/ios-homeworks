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
        
        let rootNavigationController = UINavigationController()

        appCoordinator = TabBarCoordinator(navigationController: rootNavigationController)
        
        // activate main window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        let randomCase = Int.random(in: 0...2)
        let appConfiguration: AppConfiguration
        
        switch randomCase {
        case 0:
            appConfiguration = .people("https://swapi.dev/api/people/8»")
        case 1:
            appConfiguration = .planets("https://swapi.dev/api/planets/5»")
        default:
            appConfiguration = .starships("https://swapi.dev/api/starships/3»")
        }
        
        appCoordinator?.start()
        
        return true
    }
}

