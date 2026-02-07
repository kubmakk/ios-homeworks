//
//  PostTableViewCell.swift
//  Navigation
//

import UIKit
import StorageService
import iOSIntPackage

protocol PostTableViewCellDelegate: AnyObject {
    func postCellToggleFavorite(_ cell: PostTableViewCell, post: Post)
}

class PostTableViewCell: UITableViewCell {
    
    private var viewCounter = 0
    private let imageProcessor = ImageProcessor()
    weak var delegate: PostTableViewCellDelegate?
    private(set) var currentPost: Post?
    
    private lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        recognizer.numberOfTapsRequired = 2
        recognizer.delaysTouchesBegan = false
        return recognizer
    }()

    // MARK: Visual objects
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    var postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()


    var postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let normal = UIImage(systemName: "heart")
        let selected = UIImage(systemName: "heart.fill")
        button.setImage(normal, for: .normal)
        button.setImage(selected, for: .selected)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(handleFavoriteTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Init section
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postAuthor, postImage, postDescription, postLikes, postViews, favoriteButton)
        setupConstraints()
        self.selectionStyle = .default
        contentView.addGestureRecognizer(doubleTapRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.image = nil
        favoriteButton.isSelected = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indent),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.56),
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: LayoutConstants.indent),

            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: LayoutConstants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: LayoutConstants.indent),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),

            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: LayoutConstants.indent),
            postViews.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -LayoutConstants.indent),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),

            favoriteButton.centerYAnchor.constraint(equalTo: postViews.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    // MARK: - Configuration Methods
    
    func configPostArray(post: Post) {
        self.currentPost = post
        postAuthor.text = post.author
        postDescription.text = post.description
        if let originalImage = UIImage(named: post.image) {
            postImage.image = originalImage
        }
        postLikes.text = "Likes: \(post.likes)"
        viewCounter = post.views
        postViews.text = "Views: \(viewCounter)"
        favoriteButton.isSelected = CoreDataManager.shared.isFavorite(post: post)
    }
    
    func configure(with apiPost: ApiPost) {
        self.currentPost = nil
        
        postAuthor.text = apiPost.title
        postDescription.text = apiPost.description
        
        postLikes.text = "Likes: \(Int.random(in: 0...100))"
        viewCounter = Int.random(in: 100...5000)
        postViews.text = "Views: \(viewCounter)"
        
        postImage.image = UIImage(systemName: "photo")
        postImage.load(from: apiPost.thumbnail)
        
        favoriteButton.isSelected = false
    }
    
    func incrementPostViewsCounter() {
        viewCounter += 1
        postViews.text = "Views: \(viewCounter)"
    }

    // MARK: - Actions
    @objc private func handleDoubleTap() {
        guard let post = currentPost else { return }
        delegate?.postCellToggleFavorite(self, post: post)
    }

    @objc private func handleFavoriteTap() {
        guard let post = currentPost else { return }
        delegate?.postCellToggleFavorite(self, post: post)
    }
}

// MARK: - Extension for Image Loading
extension UIImageView {
    func load(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
