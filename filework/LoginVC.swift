//
//  LoginVC.swift
//  filework
//
//  Created by kubmakk on 24/9/25.
//

import UIKit

class LoginViewController: UIViewController {
    private enum State {
        case CreatePass
        case confirmPass(firstPass: String)
        case login
    }
    
    private var currentState: State = .login
    
    var success: (() -> Void)?
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.borderStyle = .roundedRect
        field.placeholder = "Минимум 4 символа"
        field.textAlignment = .center
        return field
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        if PasswordManager.shared.isPasswordSet {
            currentState = .login
        } else {
            currentState = .CreatePass
        }
        updateUIfromState()
        
        updateUIfromState()
    }
    
    private func updateUIfromState(){
        passwordField.text = ""
        
        switch currentState {
        case .CreatePass:
            infoLabel.text = "Создайте пароль"
            actionButton.setTitle("Создать", for: .normal)
        case .confirmPass:
            infoLabel.text = "Пароль должен совпадать"
            actionButton.setTitle( "Повторить", for: .normal)
        case .login:
            infoLabel.text = "Пароль для входа"
            actionButton.setTitle("Войти", for: .normal)
        }
    }
    
    private func setupUI() {
            view.addSubview(infoLabel)
            view.addSubview(passwordField)
            view.addSubview(actionButton)
            
            NSLayoutConstraint.activate([
                infoLabel.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -20),
                infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                passwordField.heightAnchor.constraint(equalToConstant: 44),
                
                actionButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
                actionButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
                actionButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
                actionButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    
    private func handleInitialCreate(password: String) {
        if password.count < 4 {
            showAlert(title: "Ошибка", message: "Пароль должен содержать минимум 4 символа.")
            return
        }
        
        currentState = .confirmPass(firstPass: password)
        updateUIfromState()
    }
    
    private func confirmPass(firstPass: String, secondPass: String){
        if firstPass == secondPass {
            do {
                try PasswordManager.shared.save(password: secondPass)
            } catch{
                showAlert(title: "Ошибка", message: "Пароль не сохранен")
            }
        } else {
            showAlert(title: "Ошибка", message: "Пароли не совпадают")
            currentState = .CreatePass
            updateUIfromState()
        }
    }
    
    private func loginUser(password: String){
        if PasswordManager.shared.check(password: password) {
            success?()
        } else {
            showAlert(title: "Ошибка", message: "Пароль не верный")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func buttonTapped() {
        guard let password = passwordField.text, !password.isEmpty else { return }
        
        switch currentState{
        case .CreatePass:
            handleInitialCreate(password: password)
        case .confirmPass(firstPass: let firstPass):
            confirmPass(firstPass: firstPass, secondPass: password)
        case .login:
            loginUser(password: password)
        }
    }
}

