import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Subview
    private var profileHeaderView: ProfileHeaderController = {
        let view = ProfileHeaderController()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Profile"
        view.addSubview(profileHeaderView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -16),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0)
        ])
    }
}
