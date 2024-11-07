//
//  LogInViewController.swift
//  Navigation
//
//  Created by kubmakk on 08.11.2024.
//
import UIKit

class LogInViewController: UIViewController {
    
    lazy private var logoIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoIcon)
        view.addSubview(loginField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            //logo
            logoIcon.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor, constant: 150),
            logoIcon.widthAnchor.constraint(
                equalToConstant: 100),
            logoIcon.heightAnchor.constraint(
                equalToConstant: 100),
            logoIcon.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            //Field login
            loginField.topAnchor.constraint(
                equalTo: logoIcon.bottomAnchor,
                constant: 120),
            loginField.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 16),
            loginField.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: -16)
            
        ])

    }
}
