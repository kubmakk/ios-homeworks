//
//  PostTableViewCell.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 31.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let postTextView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.isEnabled = false
        textView.lineBreakStrategy = .hangulWordPriority
        textView.numberOfLines = 0
        textView.textAlignment = .left
        return textView
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        constraints()
        self.separatorInset.right = 15
        self.separatorInset.left = 15
    }
    func constraints(){
        NSLayoutConstraint.activate([
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.viewsLabel.heightAnchor.constraint(equalToConstant: 15),
            
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.authorLabel.heightAnchor.constraint(equalToConstant: 25),
            
            self.likesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            self.likesLabel.heightAnchor.constraint(equalToConstant: 15),
            
            self.postTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.postTextView.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 5),
            self.postTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.postTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25),
            
            self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 5),
            self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    func addSubview(){
        self.contentView.addSubview(viewsLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(postTextView)
        self.contentView.addSubview(likesLabel)
    }
    func setupCell(image: String) {
            postImageView.image = UIImage(named: image)
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
