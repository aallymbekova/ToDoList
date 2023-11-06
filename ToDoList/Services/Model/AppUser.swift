//
//  AppUser.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

struct AppUser: Hashable, Decodable {
    var userName: String = ""
    var email: String
    var avatarStringURL: String = ""
    var description: String = ""
    var gender: String = ""
    var uid: String
    
    init(userName: String,email: String, avatarStringURL: String, description: String, gender: String,  id: String  ) {
        self.userName = userName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.uid = id
    }
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let userName = data["userName"] as? String,
              let email = data["email"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let description = data["description"] as? String,
              let gender = data["gender"] as? String,
              let id = data["uid"] as? String
        else { return nil}
        
        self.userName = userName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.uid = id
    }
    
    var representation: [String: Any] {
        var rep = ["userName": userName]
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["gender"] = gender
        rep["uid"] = uid
        return rep
    }
}

