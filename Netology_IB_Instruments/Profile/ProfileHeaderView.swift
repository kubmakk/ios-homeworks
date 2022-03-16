//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 27.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView = UIImageView(image: UIImage(named: "elephant.jpg"))
    let fullNameLabel = UILabel()
    let statusLabel = UILabel()
    let statusTextField = UITextField()
    let setStatusButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImageView)
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.avatarImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),
            self.avatarImageView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 110)
        ]
            .forEach { $0.isActive = true }
        
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 55
        avatarImageView.layer.masksToBounds = true
        
        self.addSubview(fullNameLabel)
        self.fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Слон редкий"
        fullNameLabel.textColor = .black
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        [
            self.fullNameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 150
            ),
            self.fullNameLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 27
            ),
            self.fullNameLabel.widthAnchor.constraint(equalToConstant: 150),
            self.fullNameLabel.heightAnchor.constraint(equalToConstant: 18)
        ]
            .forEach { $0.isActive = true }
        
        self.addSubview(setStatusButton)
        self.setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.setTitle("Показать статус", for: .normal)
        [
            self.setStatusButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),
            self.setStatusButton.topAnchor.constraint(
                equalTo: self.avatarImageView.bottomAnchor,
                constant: 16
            ),
            self.setStatusButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ]
            .forEach { $0.isActive = true }
        
        setStatusButton.titleLabel?.textColor = .white
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.cornerRadius = 4
        
        self.setStatusButton.addTarget(self, action: #selector(showStatusButtonPressed), for: .touchUpInside)

        
        self.addSubview(statusLabel)
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Люблю рыбий жир"
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        [
            self.statusLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 150
            ),
            self.statusLabel.topAnchor.constraint(
                equalTo: self.setStatusButton.topAnchor,
                constant: -80
            ),
            self.statusLabel.widthAnchor.constraint(equalToConstant: 190),
            self.statusLabel.heightAnchor.constraint(equalToConstant: 14)
        ]
            .forEach { $0.isActive = true }
        
        self.addSubview(statusTextField)
        self.statusTextField.translatesAutoresizingMaskIntoConstraints = false
        [
            self.statusTextField.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 140
            ),
            self.statusTextField.topAnchor.constraint(
                equalTo: self.setStatusButton.topAnchor,
                constant: -50
            ),
            self.statusTextField.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
            .forEach { $0.isActive = true }
        statusTextField.layer.backgroundColor = UIColor.white.cgColor
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.textAlignment = .center
        
        self.statusTextField.addTarget(self, action: #selector( statusTextChanged(_:)), for: .editingChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var statusText:String = ""
    
@objc
    func showStatusButtonPressed() {
        statusLabel.text = statusText
        print(statusLabel.text ?? "nil")
    }
@objc
    func statusTextChanged(_ textField: UITextField){
        if let text = textField.text {
            statusText = text
        }
    }
}
