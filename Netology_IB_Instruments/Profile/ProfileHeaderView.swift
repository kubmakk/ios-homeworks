//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 27.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let nickNameLabel = UILabel()
    let avatarImageView = UIImageView(image: UIImage(named: "elephant.jpg"))
    let showStatusButton = UIButton()
    let statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImageView)
        avatarImageView.frame = CGRect(x: 16, y:(UIApplication.shared.windows.first{$0.isKeyWindow }?.safeAreaInsets.top ?? 0)*3 + 16, width: 110, height: 110)
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 55
        avatarImageView.layer.masksToBounds = true
        
        self.addSubview(nickNameLabel)
        nickNameLabel.text = "Слон редкий"
        nickNameLabel.textColor = .black
        nickNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nickNameLabel.frame = CGRect(x: 150, y: (UIApplication.shared.windows.first{$0.isKeyWindow }?.safeAreaInsets.top ?? 0)*3 + 27, width: 150, height: 18)
        
        self.addSubview(showStatusButton)
        showStatusButton.setTitle("Показать статус", for: .normal)
        showStatusButton.frame = CGRect(x: 16, y: avatarImageView.frame.minY + avatarImageView.frame.width + 16, width: (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width ?? 150) - 32, height: 50)
        showStatusButton.titleLabel?.textColor = .white
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.cornerRadius = 4
        
        self.addSubview(statusLabel)
        statusLabel.text = "Люблю рыбий жир"
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.frame = CGRect(x: 150, y: showStatusButton.frame.minY - 48, width: 190, height: 14)
        
        self.showStatusButton.addTarget(self, action: #selector(showStatusButtonPressed), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
@objc
    func showStatusButtonPressed() {
        print(statusLabel.text ?? "nil")
    }
}
