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
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = self.view.frame
    }
}
