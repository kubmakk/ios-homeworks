//
//  AppDelegate.swift
//  Navigation
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    
    var window: UIWindow?
    var appCoordinator: TabBarCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootNavigationController = UINavigationController()
        
        FirebaseApp.configure()
        
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
            print("выбраны люди")
        case 1:
            appConfiguration = .planets("https://swapi.dev/api/planets/5»")
            print("Выбраны планеты")
        default:
            appConfiguration = .starships("https://swapi.dev/api/starships/3»")
            print("Выбраны корабли")
        }
        
        NetworkService.reqiuest(for: appConfiguration)
        
        appCoordinator?.start()
        
        return true
    }
}

