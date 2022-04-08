//
//  InfoViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 20.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("press me", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    func addAlertButton(){
        self.view.addSubview(alertButton)
        alertButton.addTarget(self, action: #selector(tapAlertButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
                    alertButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    
                    alertButton.heightAnchor.constraint(equalToConstant: 50),
                    
                    alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
                    
                    alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
                ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        addAlertButton()
    }
    @objc func tapAlertButton(){
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
