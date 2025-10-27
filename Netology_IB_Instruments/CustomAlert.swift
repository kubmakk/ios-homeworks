//
//  CustomAlert.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 10.08.2022.
//

import Foundation
import UIKit

func customAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Alert Error"), message: message, preferredStyle: .alert)
    let actionOk = UIAlertAction(title: NSLocalizedString("Ok", comment: "Alert Ok"), style: .cancel) { actionOk in
        print("Tap Ok")
    }
    alert.addAction(actionOk)
    return alert
}
