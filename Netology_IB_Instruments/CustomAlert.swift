//
//  CustomAlert.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 10.08.2022.
//

import Foundation
import UIKit

func customAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK", style: .cancel) { actionOk in
        print("Tap Ok")
    }
    alert.addAction(actionOk)
    return alert
}
