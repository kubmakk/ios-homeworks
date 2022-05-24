//
//  CustomButton.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 22.05.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    var title: String?
    var color: UIColor?
//    var type: UIButton.ButtonType?
    var tapAction: (() -> Void)?
    
    
//    required init(type: UIButton.ButtonType?) {
//        self.type = type
//        super.init(frame: .zero)
//        translatesAutoresizingMaskIntoConstraints = false
//        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//    }
    
//    convenience init(type: UIButton.ButtonType?) {
//        self.init(title: nil, color: .white)
//        self.type = type
//        translatesAutoresizingMaskIntoConstraints = false
//    }
    required init(title: String?, color: UIColor?) {
        // set myValue before super.init is called
        self.title = title
        self.color = color
        super.init(frame: .zero)
        // set other operations after super.init, if required
        setTitle(title, for: .normal)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func buttonTapped(){
        tapAction?()
        print(#function)
    }

}
