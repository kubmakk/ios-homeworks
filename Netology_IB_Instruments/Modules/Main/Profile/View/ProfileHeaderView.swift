//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 27.02.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 55
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .center
        return textField
    }()
    let setStatusButton: CustomButton = {
        let button = CustomButton(title: NSLocalizedString("Show status", comment: "Name button"), color: .systemBlue)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        constraints()
        setupStatusTextField()
        showStatusButtonPressed()
    }
    func addSubview(){
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
    }
    func constraints(){
        self.avatarImageView.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.height.width.equalTo(110)
        }
        self.fullNameLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(150)
            make.top.equalToSuperview().inset(27)
            make.height.equalTo(18)
            make.width.equalTo(150)
        }
        self.statusLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(150)
            make.top.equalTo(self.setStatusButton).inset(-80)
            make.height.equalTo(14)
            make.width.equalTo(190)
        }
        self.statusTextField.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(140)
            make.top.equalTo(self.setStatusButton).inset(-50)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        self.setStatusButton.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    func setupStatusTextField(){
        self.statusTextField.addTarget(self, action: #selector( statusTextChanged(_:)), for: .editingChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var statusText:String = ""
@objc
    func showStatusButtonPressed() {
        setStatusButton.tapAction = { [weak self] in
            self?.statusLabel.text = self?.statusText
            print(self?.statusLabel.text ?? "nil")
        }
    }
@objc
    func statusTextChanged(_ textField: UITextField){
        if let text = textField.text {
            statusText = text
        }
    }
}
