//
//  PhotosCollectionViewCell.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 07.04.2022.
//

import UIKit
//import iOSIntPackage

class PhotosCollectionViewCell: UICollectionViewCell {
//    private lazy var imageProcessor = ImageProcessor()
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func setupCell(image: String) {
//        guard let filter = ColorFilter.allCases.randomElement() else {return}
//        guard let inputImage = UIImage(named: image) else {return}
//        imageProcessor.processImage(sourceImage: inputImage, filter: filter) { outputImage in
//            photoImageView.image = outputImage
//        }
//        imageProcessor.processImagesOnThread(sourceImages: <#T##[UIImage]#>, filter: <#T##ColorFilter#>, qos: <#T##QualityOfService#>, completion: <#T##([CGImage?]) -> Void#>)
//    }
}

