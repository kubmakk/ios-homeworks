import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Subview
    private var profileHeaderView: ProfileHeaderController = {
        let view = ProfileHeaderController()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click Me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Profile"
        
        view.addSubview(profileHeaderView)
        view.addSubview(actionButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 0
            ),
            profileHeaderView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: 0
            ),
            profileHeaderView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 0
            ),
            profileHeaderView.heightAnchor.constraint(
                equalToConstant: 220
            ),
            
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: 0
            ),
            actionButton.bottomAnchor.constraint(
                equalTo: safeAreaGuide.bottomAnchor,
                constant: 0
            ),
            actionButton.heightAnchor.constraint(
                equalToConstant: 50
            )
            
        ])
    }
}
