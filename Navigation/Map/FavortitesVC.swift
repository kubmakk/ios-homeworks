//
//  FavortitesVC.swift
//  Navigation
//
//  Created by kubmakk on 2/10/25.
//

import UIKit
import StorageService

final class FavoritesViewController: UIViewController {
    static let postIdent = "post"

    private var posts: [Post] = []

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostTableViewCell.self, forCellReuseIdentifier: Self.postIdent)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        reloadData()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadOnAppear), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesDidChange), name: .favoritesDidChange, object: nil)
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func reloadOnAppear() {
        reloadData()
    }

    private func reloadData() {
        let favorites = CoreDataManager.shared.fetchFavorites()
        posts = favorites.map { CoreDataManager.shared.mapToPost($0) }
        tableView.reloadData()
    }
    
    @objc private func favoritesDidChange() {
        reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
            cell.configPostArray(post: posts[indexPath.row])
            cell.delegate = self
            return cell
        }
}


extension FavoritesViewController: PostTableViewCellDelegate {
    func postCellToggleFavorite(_ cell: PostTableViewCell, post: Post) {
        CoreDataManager.shared.removeFavorite(for: post)
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


