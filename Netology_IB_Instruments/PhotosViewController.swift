//
//  PhotosViewController.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 07.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    let array = Array.init(1...20)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        //layout.minimumInteritemSpacing = 8
        //layout.minimumLineSpacing = 8
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
    func addCollectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallery"
        navigationController?.navigationBar.isHidden = false
        addCollectionView()
        
    }
}

extension PhotosViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.photoImageView.image = UIImage(named: String(array[indexPath.item]))
        
        return cell
    }
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(collectionView.frame.width / 3) - 12, height: floor(collectionView.frame.width / 3) - 12)
    }
   }


