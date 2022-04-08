//
//  PhotosTableViewCell.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 03.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var width:CGFloat = {
        if var widthH = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width {
            widthH = (widthH - 48)/4
            return widthH
        }
        return 0
    }()
    let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    func addPhotoLabel(){
        self.contentView.addSubview(photoLabel)
        NSLayoutConstraint.activate([
            self.photoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            self.photoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            
            //self.photoLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            
            self.photoLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    let arrow: UILabel = {
        let label = UILabel()
        label.text = "→"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    func addArrow(){
        self.contentView.addSubview(arrow)
        NSLayoutConstraint.activate([
            self.arrow.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
            
            self.arrow.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            
            self.arrow.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            
            self.arrow.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    let photoImageView:UIImageView = addPhotoImageView()
//    func addPhotoImageView(){
//        self.contentView.addSubview(photoImageView)
//        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
//
//            self.photoImageView.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
//
//            self.photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
//
//            self.photoImageView.heightAnchor.constraint(equalToConstant: (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width ?? 0 - 48)/4),
//
//            self.photoImageView.widthAnchor.constraint(equalTo: self.photoImageView.heightAnchor)
//        ])
//    }
    let photoImageView1: UIImageView = addPhotoImageView()
    
    let photoImageView2: UIImageView = addPhotoImageView()
    
    let photoImageView3: UIImageView = addPhotoImageView()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    func addStackView(){
        self.stackView.addArrangedSubview(photoImageView)
        self.stackView.addArrangedSubview(photoImageView1)
        self.stackView.addArrangedSubview(photoImageView2)
        self.stackView.addArrangedSubview(photoImageView3)
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            self.stackView.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
            
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            
            self.stackView.heightAnchor.constraint(equalToConstant: width),
            
            self.photoImageView.widthAnchor.constraint(equalToConstant: width),
            
            self.photoImageView1.widthAnchor.constraint(equalToConstant: width),

            self.photoImageView2.widthAnchor.constraint(equalToConstant: width),

            self.photoImageView3.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addPhotoLabel()
        addArrow()
        addStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
func addPhotoImageView()-> UIImageView{
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .black
    imageView.layer.cornerRadius = 6
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}
