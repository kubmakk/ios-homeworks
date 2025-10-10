//
//  MapCoord.swift
//  Navigation
//
//  Created by kubmakk on 10/10/25.
//

import UIKit

final class MapCoordinator: BaseCoordinator {
    override func start() {
        let vc = MapViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}



