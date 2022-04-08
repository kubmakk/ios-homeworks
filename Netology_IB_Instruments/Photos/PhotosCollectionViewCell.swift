//
//  PhotosCollectionViewCell.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 07.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
        
    let photoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.backgroundColor = .black
        //imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    func setupPhotoImageView(){
        self.contentView.addSubview(photoImageView)
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
//    private let label: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.textColor = .yellow
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setup() {
//        contentView.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ])
//    }
//
//    func configure(with text: String) {
//        label.text = text
//    }
}

//struct Photo {
//    let photo: String
//}
//
//let photo = Photo(photo: "1")

