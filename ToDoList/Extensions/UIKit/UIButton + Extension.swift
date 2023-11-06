//
//  UIButton + Extension.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .interSemiBold14(),
                     isShadow: Bool = false ,
                     cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 4
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    
    }
    
}

