//
//  PostViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 20.02.2022.
//

import UIKit

class PostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.title = newPost.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Info", comment: "Name NavigationItem"), style:.plain, target: self, action: #selector(tapButton))
    }
    @objc func tapButton(){
        let vc = InfoViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
