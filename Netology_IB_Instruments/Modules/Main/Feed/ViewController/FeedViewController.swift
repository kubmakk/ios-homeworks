//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 19.02.2022.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    weak var viewModel: FeedViewModel?
    
    let model = Model()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    let label = UILabel()
    let buttonOne = CustomButton(title: NSLocalizedString("Push", comment: "Name button"), color: .red)
    let buttonTwo = CustomButton(title: NSLocalizedString("Pop", comment: "Name button"), color: .blue)
    let buttonThree = CustomButton(title: NSLocalizedString("Goto Post", comment: "Name button"), color: .systemMint)
    let customButton = CustomButton(title: NSLocalizedString("Check", comment: "Name button"), color: .systemIndigo)
    let customTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.placeholder = NSLocalizedString("Give me password and Tap check", comment: "Placeholder")
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraints()
        gotoPostViewcontroller()
        tapCheckButton()
        NotificationCenter.default.addObserver(self, selector: #selector(someChange), name: NSNotification.Name("myEvent"), object: nil)
    }
    func addSubviews(){
        self.stackView.addArrangedSubview(buttonOne)
        self.stackView.addArrangedSubview(buttonTwo)
        self.stackView.addArrangedSubview(buttonThree)
        self.stackView.insertArrangedSubview(customTextField, at: 0)
        self.stackView.insertArrangedSubview(customButton, at: 1)
        self.view.addSubview(stackView)
    }
    func constraints(){
        self.stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(200)
        }
        self.buttonOne.snp.makeConstraints { make in
            make.height.equalTo(self.buttonTwo.snp.height)
        }
        self.buttonTwo.snp.makeConstraints { make in
            make.height.equalTo(self.buttonThree.snp.height)
        }
    }
    
    func gotoPostViewcontroller(){
        buttonOne.tapAction = { [weak self] in
            self?.viewModel?.push()
        }
        buttonTwo.tapAction = { [weak self] in
            self?.coordinator?.pop()
        }
        buttonThree.tapAction = { [weak self] in
            self?.coordinator?.goToPost()
        }
    }
    @objc func tapCheckButton(){
        customButton.tapAction = { [weak self] in
            guard let text = self?.customTextField.text, text != "" else { return }
            self?.model.check(word: text)
        }
    }
    @objc func someChange(){
        if self.model.check {
            print("Good")
            label.text = NSLocalizedString("Correct password", comment: "Answer")
            label.textColor = .green
            self.stackView.insertArrangedSubview(label, at: 0)
        } else {
            print("Bad")
            label.text = NSLocalizedString("Wrong password", comment: "Answer")
            label.textColor = .red
            self.stackView.insertArrangedSubview(label, at: 0)
        }
    }
}
struct PostTitle {
    var title:String
}
var newPost = PostTitle(title: NSLocalizedString("Post", comment: "Name NavigationItem"))
