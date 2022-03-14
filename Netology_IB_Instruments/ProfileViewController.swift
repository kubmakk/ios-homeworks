//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeaderView)
        self.profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.profileHeaderView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
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
//        super.viewWillLayoutSubviews()
//        profileHeaderView.frame = self.view.frame
    }
}
