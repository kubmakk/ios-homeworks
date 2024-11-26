import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Subview
    
    private var profileTableView: ProfileTableHeaderView = {
        let view = ProfileTableHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Profile"
        
        view.addSubview(profileTableView)
        
        setupConstraints()
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
            )
            
        ])
    }
}
