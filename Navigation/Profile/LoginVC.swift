//
//  LoginViewController.swift
//  Navigation
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    // MARK: Visual content
    var currentUserService: UserService?
    weak var coordinator: LoginCoordinator?
    var checkerService: CheckerServiceProtocol!
    private let passwordCracker = PasswordCracker()

    
    var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    
    lazy var loginButton: CustomButton = {
        var button = CustomButton(
            title: "Login",
            titleColor: .white,
            backroundColor: .black,
            radius: 9,
            autoresizing: false,
            target: self,
            selector: #selector(touchLoginButton)
        )
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }
        button.clipsToBounds = true
        return button
    }()
    
    lazy var bruteButton: UIButton = {
        var button = CustomButton(
            title: "Подобрать",
            titleColor: .white,
            backroundColor: .black,
            radius: 9,
            autoresizing: false,
            target: self,
            selector: #selector(startBruteForce)
        )
        button.clipsToBounds = true
        return button
    }()
    
    var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Log In"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
    
    // MARK: - Setup section
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupPasswordFieldAccessory()
        userInfo()
        
    }

    private func setupPasswordFieldAccessory() {
            passwordField.rightView = activityIndicator
            passwordField.rightViewMode = .always
        }
    
    func userInfo() {
        #if DEBUG
        currentUserService = TestUserService()
        #else
        let avatar = UIImage(named: "teo")!
        let user = User(login: "testUser", fullName: "John Doe", avatar: avatar, status: "Active")
        currentUserService = CurrentUserService(user: user)
        #endif
    }
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        
        contentView.addSubviews(vkLogo, loginStackView, loginButton, bruteButton)
        
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        
        loginField.delegate = self
        passwordField.delegate = self
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),

            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            bruteButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LayoutConstants.indent),
            bruteButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            bruteButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            bruteButton.heightAnchor.constraint(equalToConstant: 50),
            bruteButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // MARK: - Event handlers
//    @objc private func touchLoginButton() {
//        guard let login = loginField.text,
//                let password = passwordField.text else {return}
//        
//        if loginDelegate?.check(login: login, password: password) == true {
//            let profileVC = ProfileViewController()
//            navigationController?.setViewControllers([profileVC], animated: true)
//        } else{
//            let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "ОК", style: .default)
//            alert.addAction(ok)
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
    
    @objc private func touchLoginButton() {
        print("Login tapped")
        let email = (loginField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = (passwordField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Введите email и пароль")
            return
        }
        guard password.count >= 6 else {
            showAlert(message: "Пароль должен быть не короче 6 символов")
            return
        }

        print("Отправляю в Firebase -> Email: '\(email)', Длина пароля: \(password.count)")
        activityIndicator.startAnimating()
        loginButton.isEnabled = false

        #if DEBUG
        try? Auth.auth().signOut()
        #endif

        checkerService.checkCredentials(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                self.loginButton.isEnabled = true
                print("получил ответ")

                switch result {
                case .success:
                    print("Авторизация прошла успешно!")
                    self.openMain() // <-- ВАЖНО: реально перейти дальше
                case .failure(let error):
                    print("----- FIREBASE ERROR DETAILS -----")
                    print("Error object: \(error)")
                    print("Localized Description: \(error.localizedDescription)")
                    let nsError = error as NSError
                    print("Error Code: \(nsError.code)")
                    print("Error Domain: \(nsError.domain)")
                    print("User Info: \(nsError.userInfo)")
                    print("---------------------------------")

                    let errorMessage = self.firebaseErrorMessage(error)
                    self.showAlert(message: errorMessage)
                }
            }
        }
    }

    private func openMain() {
        let vc = ProfileViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }

    
    
    
    private func showAlert(title: String = "Ошибка", message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }

        // Вспомогательная функция для парсинга ошибок Firebase
        private func firebaseErrorMessage(_ error: Error) -> String {
            if let errCode = AuthErrorCode(rawValue: error._code) {
                switch errCode {
                case .invalidCredential:
                    return "Ошибка аутентификации. Возможно, неверно сконфигурирован проект."
                case .invalidEmail:
                    return "Некорректный формат email."
                case .wrongPassword:
                    return "Введен неверный пароль."
                case .userDisabled:
                    return "Аккаунт этого пользователя был отключен."
                case .emailAlreadyInUse:
                    return "Этот email уже используется другим аккаунтом."
                case .weakPassword:
                    return "Пароль слишком слабый. Он должен содержать не менее 6 символов."
                default:
                    return "Произошла неизвестная ошибка. Попробуйте снова."
                }
            }
            return error.localizedDescription
        }

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = keyboardSize.height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func generateRandomPassword(length: Int) -> String {
            let characters = String().printable
            return String((0..<length).map{ _ in characters.randomElement()! })
        }
    
    @objc private func startBruteForce() {
        let randomPassword = generateRandomPassword(length: 4)
        
        print("Цель: \(randomPassword)")

        self.activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.passwordCracker.bruteForce(passwordToUnlock: randomPassword){ foundPassword in
                DispatchQueue.main.async {
                    print("Найден пароль \(foundPassword)")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
            
        }
    }

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

