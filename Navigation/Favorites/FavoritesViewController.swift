//
//  FavoritesViewController.swift
//  Navigation
//
//  Recreated by Assistant on 02.10.2025.
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadOnAppear), name: .favoritesDidChange, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
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
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesViewController: PostTableViewCellDelegate {
    func postCellToggleFavorite(_ cell: PostTableViewCell, post: Post) {
        if CoreDataManager.shared.isFavorite(post: post) {
            CoreDataManager.shared.removeFavorite(for: post)
        } else {
            CoreDataManager.shared.saveFavorite(post: post)
        }
        // Remove from local data if it is no longer favorite
        if !CoreDataManager.shared.isFavorite(post: post) {
            if let index = posts.firstIndex(where: { $0.author == post.author && $0.image == post.image }) {
                posts.remove(at: index)
                tableView.performBatchUpdates({
                    tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }, completion: nil)
            } else {
                reloadData()
            }
        } else {
            // If toggled on from this screen (unlikely), refresh cell state
            if let indexPath = tableView.indexPath(for: cell) {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}


