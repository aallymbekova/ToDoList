//
//  Valifators.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import Foundation

class Validators {
    
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password ,
              let confirmPassword = confirmPassword,
              let email = email ,
              password != "",
              confirmPassword != "",
              email != ""
                
        else {
            return false
        }
        return true
    }
    
    static func isFilled(userName: String?, description: String?, gender: String?) -> Bool {
        guard let password = description ,
              let gender = gender,
              let userName = userName ,
              password != "",
              gender != "",
              userName != ""
                
        else {
            return false
        }
        return true
    }

    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
