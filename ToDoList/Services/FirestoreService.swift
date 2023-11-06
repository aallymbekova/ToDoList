//
//  FirestoreService.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import FirebaseFirestore
import FirebaseAuth
import UIKit

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping (Result<AppUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let appuser = AppUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToUser))
                    return
                }
                completion(.success(appuser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
        
    }
    
    func saveProfileWith(id: String, email: String, userName: String?, avatarImage: UIImage?, description: String?, gender: String?, completion: @escaping (Result<AppUser, Error>) -> Void) {
        
        guard Validators.isFilled(userName: userName, description: description, gender: gender) else {
            completion(.failure(UserError.notFilled))
            return
        }
    
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var appUser = AppUser(userName: userName!,
                              email: email,
                              avatarStringURL: "not exist",
                              description: description!,
                              gender: gender!,
                              id: id)
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
    
            case .success(let url):
                appUser.avatarStringURL = url.absoluteString
                self.usersRef.document(appUser.uid).setData(appUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(appUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
