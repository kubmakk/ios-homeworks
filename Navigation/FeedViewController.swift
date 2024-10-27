import UIKit
 
class FeedViewController: UIViewController {
    
    lazy private var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Посмотреть пост", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Feed"
        
        //actionButton.addTarget(self, action: "", for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
    }
}
