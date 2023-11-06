//
//  InsertabletextField.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class InsertableTextField: UITextField, UITextFieldDelegate {

     override init(frame: CGRect) {
         super.init(frame: frame)

         backgroundColor = .white
         attributedPlaceholder = NSAttributedString(string: "Write new task here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
         font = UIFont.systemFont(ofSize: 14)
         clearButtonMode = .whileEditing
         borderStyle = .line
         layer.cornerRadius = 18
         layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         layer.borderWidth = 1
         textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         layer.masksToBounds = true
         delegate = self

         let image = UIImage(systemName: "list.bullet.rectangle")
         let imageView = UIImageView(image: image)

         leftView = imageView
         leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
         leftViewMode = .always
     }

     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.insetBy(dx: 36, dy: 0)
     }

     override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.insetBy(dx: 36, dy: 0)
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.insetBy(dx: 36, dy: 0)
     }

     override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
         var rect = super.leftViewRect(forBounds: bounds)
         rect.origin.x += 12
         return rect
     }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
