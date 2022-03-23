//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 19.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let stackView = UIStackView()
    let buttonOne = UIButton()
    let buttonTwo = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonOne.setTitle("press me", for: .normal)
        self.buttonOne.backgroundColor = .red
        self.buttonOne.addTarget(self, action: #selector(gotoPostViewcontroller), for: .touchUpInside)
        self.buttonTwo.setTitle("press me", for: .normal)
        self.buttonTwo.backgroundColor = .blue
        self.buttonTwo.addTarget(self, action: #selector(gotoPostViewcontroller), for: .touchUpInside)
        
        
        self.stackView.addArrangedSubview(buttonOne)
        self.stackView.addArrangedSubview(buttonTwo)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
                [
                    self.stackView.centerYAnchor.constraint(
                        equalTo: self.view.safeAreaLayoutGuide.centerYAnchor
                    ),
                    self.stackView.heightAnchor.constraint(
                        equalToConstant: 100
                    ),
                    self.stackView.leadingAnchor.constraint(
                        equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 50),
                    self.stackView.trailingAnchor.constraint(
                        equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                        constant: -50)
                ]
                    .forEach { $0.isActive = true }
            self.buttonOne.heightAnchor.constraint(equalTo: self.buttonTwo.heightAnchor).isActive = true
    }
    @objc func gotoPostViewcontroller(){
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
struct Post {
    var title:String
}
var newPost = Post(title: "Post")
