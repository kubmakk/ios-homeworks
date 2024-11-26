import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Data
    
    fileprivate let data = Post.make()
    
    // MARK: - Subview
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        setupConstraints()
    }
    //MARK: - Private
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
            profileTableView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 0
            ),
            profileTableView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: 0
            ),
            profileTableView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 0
            ),
            profileTableView.heightAnchor.constraint(
                equalToConstant: 220
            ),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
            
            
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}
