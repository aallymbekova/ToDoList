//
//  OneLineTextField.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class OneLineTextField: UITextField, UITextFieldDelegate {
    
    convenience init(font: UIFont? = .interSemiBold10()) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 00, height: 0))
        bottomView.backgroundColor = .grayColor()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
