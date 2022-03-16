//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var profileHeaderView = ProfileHeaderView()
    let newButton = UIButton()
    var topConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeaderView)
        self.profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        [   topConstraint,
            self.profileHeaderView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            ),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor
            ),
            self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ]
            .forEach{ $0.isActive = true }
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.addSubview(newButton)
        self.newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.setTitle("Жми", for: .normal)
        [
            self.newButton.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            ),
            self.newButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            self.newButton.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            ),
            self.newButton.heightAnchor.constraint(equalToConstant: 50)
        ]
            .forEach { $0.isActive = true }
        newButton.titleLabel?.textColor = .white
        newButton.backgroundColor = .systemBlue
        newButton.layer.cornerRadius = 4
        newButton.layer.shadowOpacity = 0.7
        newButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        newButton.layer.shadowColor = UIColor.black.cgColor
        newButton.layer.cornerRadius = 4
        self.newButton.addTarget(self, action: #selector( animateProfileHeaderView), for: .touchUpInside)

    }
@objc
    func animateProfileHeaderView (){
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2){
            self.topConstraint.constant = 100
            //self.newButton.center = CGPoint(x: self.newButton.center.x, y: self.newButton.center.y-100)
//            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100)
            self.view.layoutIfNeeded()
        }
    }
}
