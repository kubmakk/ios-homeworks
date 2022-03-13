//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 19.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSafeAreaInsets.top = 500
        let button = UIButton(frame: CGRect(x: 50, y: 300, width: 200, height: 50))
        button.setTitle("press me", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func tap(){
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
struct Post {
    var title:String
}
var newPost = Post(title: "Post")
