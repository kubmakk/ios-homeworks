//
//  Coordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 04.06.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
extension Coordinator {
    
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
}
