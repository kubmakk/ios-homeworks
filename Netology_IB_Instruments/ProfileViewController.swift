//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func addProfileHeaderView(){
        self.view.addSubview(profileHeaderView)
        topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            topConstraint,
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    let newButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Жми", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    func addNewButton(){
        self.view.addSubview(newButton)
        NSLayoutConstraint.activate([
            self.newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            self.newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.newButton.addTarget(self, action: #selector( animateProfileHeaderView), for: .touchUpInside)
    }
    var topConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        addProfileHeaderView()
        self.view.backgroundColor = .lightGray

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addNewButton()

    }
@objc
    func animateProfileHeaderView (){
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2){
            self.topConstraint.constant = 100
            self.view.layoutIfNeeded()
        }
    }
}
