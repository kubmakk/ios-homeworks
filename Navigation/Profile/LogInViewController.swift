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
//        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 0
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
//        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = true
        
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        stackView.addArrangedSubview(loginField)
        stackView.addArrangedSubview(passField)
    
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(logoIcon)
//        view.addSubview(loginField)
//        view.addSubview(passField)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        
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
            //stackView
            stackView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 16),
            stackView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: -16),
            stackView.topAnchor.constraint(equalTo: logoIcon.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
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
