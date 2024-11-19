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
        textField.placeholder = "Email or Phone"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "Color")
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    lazy private var lineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        
        return line
    }()
    
    lazy private var passField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(loginField)
        stackView.addArrangedSubview(lineView)
        stackView.addArrangedSubview(passField)
    
        return stackView
    }()
//MARK: Setup DidLoad
    private func setupSubviews() {
        view.addSubview(logoIcon)
        view.addSubview(stackView)
        view.addSubview(loginButton)
    }

    private func setupTargets() {
        loginButton.addTarget(self, action: #selector(buttonStateChanged), for: .allEvents)
        loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupTargets()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
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
                equalTo: stackView.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            loginField.heightAnchor.constraint(equalTo: passField.heightAnchor)
        ])
    }
}
