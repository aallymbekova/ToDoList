//
//  UILabel + Extension.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

extension UILabel {
    
    convenience init(text: String,
                     color: UIColor,
                     font: UIFont? = .interSemiBold10()) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.font = font

    }
    
}

