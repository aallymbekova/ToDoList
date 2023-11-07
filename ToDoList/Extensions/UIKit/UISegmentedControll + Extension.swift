//
//  UISegmentedControll + Extension.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

extension UISegmentedControl {
     
    convenience init(first: String, second: String, selectedColor: UIColor, backgroundColor: UIColor) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.selectedSegmentIndex = 0
        self.selectedSegmentTintColor = selectedColor
        self.backgroundColor = backgroundColor
    }
}



