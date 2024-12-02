import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Data
    fileprivate let data = Post.make()

    // MARK: - Subview
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var profileTableView: ProfileTableHeaderView = {
        let view = ProfileTableHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private enum CallReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case custom = "CustomTableViewCell_ReuseID"
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }

    // MARK: - Private
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Profile"
        navigationItem.title = "Table"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(profileTableView)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileTableView.heightAnchor.constraint(equalToConstant: 220),
            
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: profileTableView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }

    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CallReuseID.custom.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CallReuseID.custom.rawValue, for: indexPath) as! PostTableViewCell
        let post = data[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
