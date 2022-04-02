//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 19.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    func addStackView(){
        self.stackView.addArrangedSubview(buttonOne)
        self.stackView.addArrangedSubview(buttonTwo)
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
                    self.stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                    
                    self.stackView.heightAnchor.constraint(equalToConstant: 100),
                    
                    self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
                    
                    self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
                    
                    self.buttonOne.heightAnchor.constraint(equalTo: self.buttonTwo.heightAnchor)
                ])
    }
    let buttonOne: UIButton = {
        let button = UIButton()
        button.setTitle("press me", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    let buttonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("press me", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    func addButton(){
        self.buttonOne.addTarget(self, action: #selector(gotoPostViewcontroller), for: .touchUpInside)
        self.buttonTwo.addTarget(self, action: #selector(gotoPostViewcontroller), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        addStackView()
    }
    @objc func gotoPostViewcontroller(){
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
struct PostTitle {
    var title:String
}
var newPost = PostTitle(title: "Post")
