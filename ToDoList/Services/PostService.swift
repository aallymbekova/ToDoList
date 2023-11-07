//
//  PostService.swift
//  ToDoList
//
//  Created by darmaraht on 7/11/23.
//

import UIKit
import Firebase

class PostService {
    
    static var shared = PostService()
    
    var user: AppUser!
    var ref : DatabaseReference!

   func getCurrentUser()  {
        guard let currentUser = Auth.auth().currentUser else { return }
        user = AppUser(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    func newTaks(text: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        getCurrentUser()
        let task = Task(title: text, userId: user.uid)
        let taskRef = ref.child(task.title.lowercased())
        taskRef.setValue( ["title": task.title, "userId": task.userId, "completed": task.completed], withCompletionBlock: completion)
    }
    
    func fetchAllItems(completion: @escaping([Task]) -> Void ) {
        getCurrentUser()
        
        ref.observe(.value) { snapshot in
            var _tasks = Array<Task>()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
                completion(_tasks)
               
            }
        }
    }
}
