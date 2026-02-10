//
//  ProfileViewController.swift
//  Navigation
//

import UIKit
import StorageService
import FirebaseAuth

final class ProfileViewController: UIViewController {
    
    private var apiPosts: [ApiPost] = []
    
    static let headerIdent = "header"
    static let photoIdent = "photo"
    static let postIdent = "post"
    var user: User?
    weak var coordinator: LoginCoordinator?
    
    static var postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoIdent)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: postIdent)
        #if DEBUG
        table.backgroundColor = .systemGray6
        #else
        table.backgroundColor = .systemGray6
        #endif
        return table
    }()
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(Self.postTableView)
        setupConstraints()
        Self.postTableView.dataSource = self
        Self.postTableView.delegate = self
        Self.postTableView.refreshControl = UIRefreshControl()
        Self.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        
        fetchPosts()
    }
    
    private func fetchPosts() {
        NetworkService.shared.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.apiPosts = posts
                    Self.postTableView.reloadData()
                    Self.postTableView.refreshControl?.endRefreshing()
                case .failure(let error):
                    print("Ошибка загрузки постов: \(error.localizedDescription)")
                    self?.showErrorAlert()
                    Self.postTableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить новости", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            Self.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Self.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Self.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            Self.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func reloadTableView() {
        fetchPosts()
    }
}

// MARK: - Extensions

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1:
            return apiPosts.count
        default:
            assertionFailure("no registered section")
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.photoIdent, for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
            let post = apiPosts[indexPath.row]
            cell.configure(with: post)
            cell.delegate = self
            return cell
        default:
            assertionFailure("no registered section")
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdent) as? ProfileHeaderView else {
            return nil
        }

        if let currentUser = Auth.auth().currentUser, let email = currentUser.email {
            headerView.configure(email: email)

        } else {
            headerView.configure(email: "Гость")
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell else { return }
            cell.incrementPostViewsCounter()
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            assertionFailure("no registered section")
        }
    }
}

// MARK: - PostTableViewCellDelegate

extension ProfileViewController: PostTableViewCellDelegate {
    func postCellToggleFavorite(_ cell: PostTableViewCell, post: Post) {
        if CoreDataManager.shared.isFavorite(post: post) {
            CoreDataManager.shared.removeFavorite(for: post)
        } else {
            CoreDataManager.shared.saveFavorite(post: post)
        }
        if let indexPath = Self.postTableView.indexPath(for: cell),
           let updatedCell = Self.postTableView.cellForRow(at: indexPath) as? PostTableViewCell {
            updatedCell.configPostArray(post: post)
        }
    }
}

