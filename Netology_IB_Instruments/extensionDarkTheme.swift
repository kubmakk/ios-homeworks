//
//  extensionDarkTheme.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 28.12.2022.
//

import Foundation
import UIKit
extension UIColor  {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
            
        }
    }
}

let textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray)
