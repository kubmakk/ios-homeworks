//
//  CustomButton.swift
//  Navigation
//
//  Created by kubmakk on 05.02.2025.
//

import UIKit

class CustomButton: UIButton {
    private var action: (() -> Void)?
    
    convenience init(title: String, titleColor: UIColor, backroundColor: UIColor, radius: CGFloat, action: @escaping () -> Void){
        self.init(type: .custom)
        self.action = action
        setupButton(title: title, titleColor: titleColor, backroundColor: backroundColor, radius: radius)
    }
    
    private func setupButton(title: String, titleColor: UIColor, backroundColor: UIColor, radius: CGFloat){
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backroundColor
        layer.cornerRadius = radius
        translatesAutoresizingMaskIntoConstraints = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(){
        action?()
    }
}
