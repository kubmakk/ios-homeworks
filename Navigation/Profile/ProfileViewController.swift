import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Data
    fileprivate let data = Post.make()

    // MARK: - Subview
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CallReuseID.custom.rawValue)
        return tableView
    }()
    
    private lazy var profileHeaderView = ProfileTableHeaderView()
    private var avatarInitialFrame: CGRect = .zero
    private var avatarImageView: UIImageView {
        return profileHeaderView.avatarImageView
    }
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.tintColor = .red
        button.alpha = 0
        //button.addTarget(ProfileViewController.self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
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
        addAvatarGesture()
    }

    // MARK: - Private
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Profile"
        navigationItem.title = "Table"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(tableView)
        view.addSubview(overlayView)
        view.addSubview(closeButton)
        
        overlayView.frame = view.bounds
        
        view.isUserInteractionEnabled = true
    }
    
    private func addAvatarGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    //MARK: - Actions

    @objc private func imageTapped() {
        let centerOrigin = avatarImageView.center
        
        UIView.animate(
            withDuration: 4.0,
            delay: 2.0,
            options: .curveEaseInOut
        ) {
            self.avatarImageView.frame = CGRect(
                x: 0,
                y: (self.view.bounds.height - self.view.bounds.width) / 2,
                width: self.view.bounds.width,
                height: self.view.bounds.width
                )
            
        } completion: { _ in
            print("Compleated")
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileHeaderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        }
        return 0
    }
}


