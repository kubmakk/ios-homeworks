//
//  PhotosViewController.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 07.04.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    private lazy var imageProcessor = ImageProcessor()
    var imagesArray: [UIImage] = []
    let imageArray1: [UIImage] = {
        var array: [UIImage] = []
        for i in 1...20 {
            if let newElement = UIImage(named: String(i)) {
                array.append(newElement)
            }
        }
        return array
    }()
    var imageArray2: [UIImage] = []
    let imagePublisherFacade = ImagePublisherFacade()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self,forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        return collection
    }()
    override func loadView() {
        super.loadView()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.title = "Photo Gallery"
        navigationController?.navigationBar.isHidden = false
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.05, repeat: 20, userImages: imageArray1)
        addFilter(inputArrayImage: imageArray1)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePublisherFacade.rechargeImageLibrary()
        imagePublisherFacade.removeSubscription(for: self)
    }
    func addFilter(inputArrayImage: [UIImage]) {
        guard let filter = ColorFilter.allCases.randomElement() else {return}
        let qualityOfServiceAllCases: [QualityOfService] = [.userInteractive, .userInitiated, .utility, .background, .default]
        guard let qualityOfService = qualityOfServiceAllCases.randomElement() else {return}
        print("Filter name \(filter), qos \(qualityOfService.rawValue)")
        timeMeasureRunningCode(title: "processImagesOnThread") {
            imageProcessor.processImagesOnThread(sourceImages: inputArrayImage, filter: filter, qos: qualityOfService) { [self] outputImage in
                
                for value in outputImage{
                    if let cgImage = value {
                        let uiImage = UIImage(cgImage: cgImage)
                        self.imageArray2.append(uiImage)
                        
                    }
                }
            }
        }
    }
}
extension PhotosViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(imagesArray.count)
        return imageArray2.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.photoImageView.image = imageArray2[indexPath.item]
        return cell
    }
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(collectionView.frame.width / 3) - 12, height: floor(collectionView.frame.width / 3) - 12)
    }
}
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        imagesArray = images
        self.collectionView.reloadData()
        //print(imagesArray)
    }
}
func timeMeasureRunningCode(title: String, operationBlock: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    operationBlock()
    let finish = CFAbsoluteTimeGetCurrent()
    let timeElapsed = finish - start
    print("Time for \(title) is \(timeElapsed) seconds.")
}
