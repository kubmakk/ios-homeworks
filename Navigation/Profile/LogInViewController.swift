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
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or phone"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        //text
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "Color")
        textField.autocapitalizationType = .none

        return textField
    }()
    
    lazy private var passField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        //text
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "Color")
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true

        return textField
    }()
    
    lazy private var loginButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.alpha = 1
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.alpha = 1
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(logoIcon)
        view.addSubview(loginField)
        view.addSubview(passField)
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(buttonStateChanged), for: .allEvents)
        loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        setupConstraints()
    }
    
    @objc func buttonStateChanged() {
        switch loginButton.state {
        case .normal:
            loginButton.alpha = 1
        case .selected, .highlighted, .disabled:
            loginButton.alpha = 0.8
        default :
            break
        }
    }
    
    @objc func loginButtonTaped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
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
                constant: -16),
            loginField.heightAnchor.constraint(equalToConstant: 50),
            //Password Field
            passField.heightAnchor.constraint(equalToConstant: 50),
            passField.topAnchor.constraint(
                equalTo: loginField.bottomAnchor,
                constant: 0),
            passField.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 16),
            passField.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: -16),
            //Action Button
            loginButton.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 16),
            loginButton.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: -16),
            loginButton.topAnchor.constraint(
                equalTo: passField.bottomAnchor,
                constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])

    }
}
