//
//  UserError.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwrapToUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Photo not exist", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Unable to get information", comment: "")
        case .cannotUnwrapToUser:
            return NSLocalizedString("Unable to convert information", comment: "")
        }
    }
}
