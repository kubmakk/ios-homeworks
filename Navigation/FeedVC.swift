//
//  FeedViewController.swift
//  Navigation
//

import UIKit
import SnapKit
final class FeedViewController: UIViewController {
    //MARK: Constraint
    
    private let secretWordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter secret word"
        return textField
    }()
    
    private var checkGuessButton = CustomButton(
        title: <#T##String#>,
        titleColor: <#T##UIColor#>,
        backroundColor: <#T##UIColor#>,
        radius: <#T##CGFloat#>,
        autoresizing: <#T##Bool#>,
        target: <#T##AnyObject#>,
        selector: <#T##Selector#>
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
        
        button.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(44)
        }
    }
    
    lazy var button = CustomButton(
        title: "Selector Butn",
        titleColor: .purple,
        backroundColor: .red,
        radius: 20,
        autoresizing: true,
        action: {self.tapPostButton()}
    )
    
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
    //MARK: lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        view.addSubview(button)
        createSubView()
    }
    //MARK: functions
    @objc func tapPostButton() {
        let post = postExamples[0]
        
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}


class FeedModel{
    private let secretWord: String
    
    init(secretWord: String) {
        self.secretWord
    }
    
    func check(word: String) -> Bool {
        word == self.secretWord
    }
}
