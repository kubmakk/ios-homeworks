//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 30.03.2025.
//

import UIKit

typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: FlowCoordinator? { get }
    func start()
}
