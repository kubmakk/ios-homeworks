//
//  FeedViewController.swift
//  Navigation
//

import UIKit
import SnapKit
final class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        createSubView()
    }
    
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
        view.addSubview(button)
        
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
        var button = CustomButton(
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
//
//    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
//        lazy var button = CustomButton(
//            title: title,
//            titleColor: .white,
//            backroundColor: color,
//            radius: LayoutConstants.cornerRadius,
//            action: {selector}
//        )
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addArrangedSubview(button)
//    }
//    
//    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(title, for: .normal)
//        button.backgroundColor = color
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = LayoutConstants.cornerRadius
//        button.addTarget(self, action: selector, for: .touchUpInside)
//        view.addArrangedSubview(button)
//    }
    
    @objc func tapPostButton() {
        let post = postExamples[0]
        
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
