//
//  FavoriteViewController.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 15.11.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var coordinator: FavoriteCoordinator?
    weak var viewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Favorites"
    }}
