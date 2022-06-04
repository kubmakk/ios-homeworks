//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 19.02.2022.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    let model = Model()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    let label = UILabel()
    let buttonOne = CustomButton(title: "press me", color: .red)
    let buttonTwo = CustomButton(title: "press me too", color: .blue)
    let customButton = CustomButton(title: "check", color: .systemIndigo)
    let customTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.placeholder = "Give me Text and Tap check"
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
    }
    @objc func gotoPostViewcontroller(){
        buttonOne.tapAction = { [weak self] in
            let vc = PostViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        buttonTwo.tapAction = buttonOne.tapAction
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
            label.text = "Good"
            label.textColor = .green
            self.stackView.insertArrangedSubview(label, at: 0)
        } else {
            print("Bad")
            label.text = "Bad"
            label.textColor = .red
            self.stackView.insertArrangedSubview(label, at: 0)
        }
    }
}
struct PostTitle {
    var title:String
}
var newPost = PostTitle(title: "Post")
