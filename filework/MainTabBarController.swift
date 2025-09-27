//
//  MainTabBarController.swift
//  filework
//
//  Created by kubmakk on 27/9/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
    }
    
    private func setupTabs(){
        let filesVC = FilesViewController()
        let settingsVC = SettingsViewController()
        
        filesVC.navigationItem.largeTitleDisplayMode = .always
        settingsVC.navigationItem.largeTitleDisplayMode = .always
        
        let filesNav = UINavigationController(rootViewController: filesVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        filesNav.tabBarItem = UITabBarItem(title: "Файлы", image: UIImage(systemName: "folder"), tag: 0)
        settingsNav.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 1)
        
        setViewControllers([filesNav, settingsNav], animated: true)
    }
}
