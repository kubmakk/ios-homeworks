import UIKit

class ProfileTableHeaderView: UIView {
    
    // MARK: - Subview
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        
        let tapImage = UITapGestureRecognizer(
            target: ProfileTableHeaderView.self,
            action: nil
        )
        imageView.addGestureRecognizer(tapImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()

        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
}
    // MARK: - Private

    private func setupViews() {
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(actionButton)
        addSubview(avatarImageView)
    }
    
    @objc func actionButtonTapped() {
        print(statusLabel.text ?? "Status is empty")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {        
        NSLayoutConstraint.activate([
            // Avatar constraints
            avatarImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            avatarImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16
            ),
            avatarImageView.widthAnchor.constraint(
                equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(
                equalToConstant: 100),
            // Name label constraints
            nameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 16),
            nameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            nameLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 27
            ),
            // Status label constraints
            statusLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 16
            ),
            statusLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            statusLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 27
            ),
            // Action button constraints
            actionButton.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            actionButton.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 16),
            actionButton.heightAnchor.constraint(
                equalToConstant: 50)
        ])
    }
}
