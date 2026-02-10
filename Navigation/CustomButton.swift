//
//  CustomButton.swift
//  Navigation
//
//  Created by kubmakk on 05.02.2025.
//

import UIKit

class CustomButton: UIButton {
    private var action: (() -> Void)?
    private var target: AnyObject?
    private var selector: Selector?
    
    
    convenience init(title: String, titleColor: UIColor, backroundColor: UIColor, radius: CGFloat, autoresizing: Bool, action: @escaping () -> Void){
        self.init(type: .custom)
        self.action = {[] in action()}
        setupButton(title: title, titleColor: titleColor, backroundColor: backroundColor, radius: radius, autoresizing: autoresizing)
    }
    
    convenience init(title: String, titleColor: UIColor, backroundColor: UIColor, radius: CGFloat, autoresizing: Bool, target: AnyObject, selector: Selector){
        self.init(type: .custom)
        self.target = target
        self.selector = selector
        setupButton(title: title, titleColor: titleColor, backroundColor: backroundColor, radius: radius, autoresizing: autoresizing)
    }
    
    private func setupButton(title: String, titleColor: UIColor, backroundColor: UIColor, radius: CGFloat, autoresizing: Bool){
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backroundColor
        layer.cornerRadius = radius
        translatesAutoresizingMaskIntoConstraints = autoresizing
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupLayer(shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float, shadowColor: UIColor){
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        
    }
    
    @objc private func buttonTapped(){
        if let action = action {
            action()
        } else if let target = target, let selector = selector {
            target.perform(selector)
        }
    }
}
