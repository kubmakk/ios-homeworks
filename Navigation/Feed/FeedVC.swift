import UIKit
import SnapKit

final class FeedViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Constraint
    
    var viewModel: FeedVM!
    weak var coordinator: FeedCoordinator?
    
    private let secretWordField: UITextField = {
        let textField = UITextField()
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 24))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter secret word"
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        textField.returnKeyType = .done // Устанавливаем тип клавиши "Done"
        return textField
    }()
    
    lazy var checkGuessButton = CustomButton(
        title: "Check",
        titleColor: .black,
        backroundColor: .systemBlue,
        radius: LayoutConstants.cornerRadius,
        autoresizing: false,
        action: { self.checkGuess() }
    )
    
    private func createSubView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
        addPostButton(title: "Post number One", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Post number Two", color: .systemIndigo, to: stackView, selector: #selector(tapPostButton))
        
        view.addSubview(secretWordField)
        view.addSubview(checkGuessButton)
        
        secretWordField.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(-16)
            make.height.equalTo(30)
        }
        checkGuessButton.snp.makeConstraints { make in
            make.top.equalTo(secretWordField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = CustomButton(
            title: title,
            titleColor: .white,
            backroundColor: color,
            radius: LayoutConstants.cornerRadius,
            autoresizing: false,
            target: self,
            selector: selector
        )
        view.addArrangedSubview(button)
    }
    
    private var model = FeedModel(secretWord: "like")
    
    // MARK: - lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        createSubView()
        let userModel = UserModel(fullName: "Some Name", status: "Some Status")
        viewModel = FeedVM(user: userModel, initialStatus: userModel.status)
        BildModel()
        NotificationCenter.default.addObserver(self, selector: #selector(tapToButn), name: .wordChecked, object: nil)
        
        // Добавляем наблюдатели за клавиатурой
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        secretWordField.delegate = self
    }
    
    // MARK: - func
    
    private func BildModel() {
        viewModel.updatedIfNeed = { [weak self] newStatus in
            guard let self = self else { return }
            
            print("Статус обновлен: \(newStatus)")
            self.checkGuessButton.setTitle("Статус: \(newStatus)", for: .normal)
        }
        
    }
    
    @objc func tapPostButton() {
        let post = postExamples[0]
        
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
        
        viewModel.updateStatus(newStatus: "Просмотрен пост")
    }
    
    @objc private func tapToButn(_ notification: Notification) {
        if let isCorrect = notification.userInfo?["result"] as? Bool {
            checkGuessButton.titleLabel?.text = isCorrect ? "Correct" : "Wrong"
            checkGuessButton.backgroundColor = isCorrect ? .green : .red
        }
    }
    
    @objc private func checkGuess() {
        guard let userInput = secretWordField.text, !userInput.isEmpty else { return }
        model.check(word: userInput)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height
        let textFieldFrame = secretWordField.convert(secretWordField.bounds, to: view)
        let textFieldBottomY = textFieldFrame.maxY
        let safeAreaBottom = view.safeAreaInsets.bottom
        let targetY = view.frame.height - keyboardHeight - safeAreaBottom - 20
        
        let offset = max(textFieldBottomY - targetY, 0)

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curve),
            animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -offset)
            }
        )
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curve),
            animations: {
                self.view.transform = .identity
            }
        )
    }


    // Очистка наблюдателей (опционально)
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class FeedModel {
    private let secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    func check(word: String) {
        let isCorrect = word == self.secretWord
        NotificationCenter.default.post(name: .wordChecked, object: nil, userInfo: ["result": isCorrect])
    }
}

// MARK: - Extension
extension Notification.Name {
    static let wordChecked = Notification.Name("wordChecked")
}
