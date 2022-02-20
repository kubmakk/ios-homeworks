//
//  InfoViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 20.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        let button = UIButton(frame: CGRect(x: 50, y: 300, width: 200, height: 50))
        button.setTitle("press me", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func tap(){
        let alertVC = UIAlertController(title: "Error", message: "Fatal Error", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { actionOk in
            print("Tap Ok")
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { actionCancel in
            print("Tap Cancel")
        }
        alertVC.addAction(actionOk)
        alertVC.addAction(actionCancel)
        self.present(alertVC, animated: true, completion: nil)
    }

}
