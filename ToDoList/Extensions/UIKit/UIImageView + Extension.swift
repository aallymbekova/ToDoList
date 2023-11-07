//
//  UIImageView + Extension.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
}
