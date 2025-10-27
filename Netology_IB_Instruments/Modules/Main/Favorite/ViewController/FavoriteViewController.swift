//
//  FavoriteViewController.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 15.11.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    enum State {
        case empty
        case hasModel(model: [Post])
    }
    
    var state: State = .empty
    private let databaseCoordinator: DatabaseCoordinatable
    var coordinator: FavoriteCoordinator?
    weak var viewModel: FavoriteViewModel?
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init (databaseCoordinator: DatabaseCoordinatable){
        self.databaseCoordinator = databaseCoordinator
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(wasLikedArticle(_:)),
                                               name: .wasLikedArticle,
                                               object: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        self.tableView.backgroundColor = .systemYellow
        self.fetchPostFromDatabase()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "idCell")
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NSLocalizedString("Favorites", comment: "Name NavigationItem")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Delete", comment: "Name NavigationItem"), style:.plain, target: self, action: #selector(action))
        //let height: CGFloat = 75
        //let navbar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: height))
        //navbar.backgroundColor = UIColor.systemBlue
        //navbar.delegate = self

       // let navItem = UINavigationItem()
       // navItem.title = ""
        //navItem.leftBarButtonItem = UIBarButtonItem(title: "Left Button", style: .plain, target: self, action: nil)
        //navItem.rightBarButtonItem = UIBarButtonItem(title: "Del", style: .plain, target: self, action: #selector(action))
        //UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(action))
        //UIBarButtonItem(title: "D", style: .plain, target: self, action: nil)

       // navbar.items = [navItem]

        //view.addSubview(navbar)

//        collectionView?.frame = CGRect(x: 0, y: height, width: UIScreen.mainScreen().bounds.width, height: (UIScreen.mainScreen().bounds.height - height))
//        guard let navItem = self.navigationController?.navigationItem else {return}
//        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(action))
    }
    func fetchPostFromDatabase() {
        self.databaseCoordinator.fetchAll(PostCoreDataModel.self) { result in
            switch result {
            case .success(let postCoreDataModels):
                print("🍇 \(dump(postCoreDataModels))")
                let posts = postCoreDataModels.map { Post(postCoreDataModel: $0) }
                self.state = posts.isEmpty ? .empty : .hasModel(model: posts)
                self.tableView.reloadData()
            case .failure(let error):
//                print("🍇 \(error)")
                self.state = .empty
            }
        }
    }
    @objc func action () {
        coordinator?.action(view: self)
    }
    @objc private func wasLikedArticle(_ notification: NSNotification) {
        print("🍇")
        self.fetchPostFromDatabase()
    }
}


// MARK: Extension
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .empty:
            return 0
        case .hasModel(let model):
            return model.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state {
        case .empty:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        case .hasModel(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as? FavoriteTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.authorLabel.text = model[indexPath.row].author
            cell.postImageView.image = UIImage(named: model[indexPath.row].image)
            cell.postTextView.text = model[indexPath.row].descript
            cell.likesLabel.text = NSLocalizedString("Likes: ", comment: "likes post") + ("\(model[indexPath.row].likes)")
            cell.viewsLabel.text = NSLocalizedString("Views: ", comment: "views post") + ("\(model[indexPath.row].views)")
            return cell
        }
    }
}
extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
