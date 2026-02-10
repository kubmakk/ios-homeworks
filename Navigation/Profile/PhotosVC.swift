//
//  PhotosViewController.swift
//  Navigation
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    let photoIdent = "photoCell"
    let imageProcessor = ImageProcessor()
    var sourseImages: [UIImage] = []
    var processedImages: [UIImage] = []
    
    // MARK: Visual objects
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        photos.dataSource = self
        photos.delegate = self
        return photos
    }()
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery"
        sourseImages = Photos.shared.examples
        processedImages = sourseImages
        
        //iPhone 16, MacBook Pro M1 Pro
        
        runImageProcessor(filter: .chrome, qos: .userInitiated)
        //1.27s
        
//        runImageProcessor(filter: .chrome, qos: .background)
//        //8.63s
        
//        runImageProcessor(filter: .chrome, qos: .default)
//        //1.40s
        
//        runImageProcessor(filter: .chrome, qos: .userInteractive)
//        //1.32
        
//        runImageProcessor(filter: .chrome, qos: .utility)
//        //1.51
        view.addSubview(photosCollectionView)
        setupConstraints()
    }
    
    private func runImageProcessor(filter: ColorFilter, qos: QualityOfService) {
        print("Начало работы с фильтром \(filter) и QoS \(qos)")
        let startTime = Date()
        
        imageProcessor.processImagesOnThread(
            sourceImages: self.sourseImages,
            filter: filter,
            qos: qos){ [weak self] cgImagesResult in
                let endTime = Date()
                let elapsedTime = endTime.timeIntervalSince(startTime)
                print("Время выполнения: \(elapsedTime) секунд")
                print("Процесс завершен")
                let resultUIImages = cgImagesResult.compactMap { $0 }.map { UIImage(cgImage: $0) }

                DispatchQueue.main.async {
                    guard let self = self else { return }
                    

                    self.processedImages = resultUIImages

                    self.photosCollectionView.reloadData()
                    print("Вернулся на главнй поток")
                }
            }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}

// MARK: - Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.56)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return processedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: processedImages[indexPath.item])
        return cell
    }
}

