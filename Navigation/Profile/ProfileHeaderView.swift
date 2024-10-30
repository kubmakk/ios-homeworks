import UIKit

class ProfileHeaderController: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .systemFont(ofSize: .init(18), weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.font = .systemFont(ofSize: .init(14), weight: .light)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(statusLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        avatarImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        statusLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 30)
        nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 30)
    }
    
    }
