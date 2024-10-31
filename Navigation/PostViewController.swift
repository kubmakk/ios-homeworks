import UIKit

class PostViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var post: Post
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти", for: .normal)
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        title = post.title
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        actionButton.addTarget(self, action: #selector(showItem), for: .touchUpInside)

        
    }
    @objc func showItem()  {
        let infoViewController = InfoViewController()
        
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        
        let navController = UINavigationController(rootViewController: infoViewController)
        present(navController, animated: true)
    }
    
}
