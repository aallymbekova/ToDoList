//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit
import Firebase
import SDWebImage

 class TaskListViewController: UIViewController {

     var tasks = Array<Task>()

     private let tableView: UITableView = {
         let tableView = UITableView()
         tableView.backgroundColor = .white
         return tableView
     }()
     
      private let userImage = UIImageView()

     
     private let currentUser: AppUser

     init(currentUser: AppUser) {
         self.currentUser = currentUser
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self

         tableView.register(TaskListViewCell.self, forCellReuseIdentifier: TaskListViewCell.reuseId)

         setupConstraints()
         setupViews()
         
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         PostService.shared.fetchAllItems { [weak self] tasks in
             self?.tasks = tasks
             self?.tableView.reloadData()
         }
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         PostService.shared.ref.removeAllObservers()
     }
 }

//MARK: - Actions

extension TaskListViewController {
    
    @objc private func signOutRightButtonTapped() {
        let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.keyWindow?.rootViewController = AuthViewController()
            } catch {
                print("Error signin out: \(error.localizedDescription)")
            }
        }))
        present(ac, animated: true, completion: nil)
    }
}

//MARK: - Extension

extension TaskListViewController {
    private func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.fillSuperview()
        
    }
    
    private func setupViews() {
         createCustomNavigationBar()
        
        guard let url = URL(string: currentUser.avatarStringURL) else { return }
        userImage.sd_setImage(with: url, completed: nil)

        let customTitleView = createCustomTitleView(userName: currentUser.userName, userImage: userImage, userDescription: currentUser.description, userGender: currentUser.gender)
        let signOutRightButton = createCustomButton(imageName: "pip.exit", selector: #selector(signOutRightButtonTapped))

         navigationItem.titleView = customTitleView
        navigationItem.rightBarButtonItem = signOutRightButton
     }
    
    func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
}
 //MARK: - UITableViewDelegate
 extension TaskListViewController: UITableViewDelegate {

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         44
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         
         guard let cell = tableView.cellForRow(at: indexPath) else { return }
         let task = tasks[indexPath.row]
         let isCompleted = !task.completed
         
         toggleCompletion(cell, isCompleted: isCompleted)
         task.ref?.updateChildValues(["completed" : isCompleted])
     }
 }

 //MARK: - UITableViewDataSource
 extension TaskListViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tasks.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: TaskListViewCell.reuseId, for: indexPath) as! TaskListViewCell

         cell.textLabel?.textColor = .black
         let task = tasks[indexPath.row]
         let taskTitle = task.title
         let isCompleted = task.completed
         cell.textLabel?.text = taskTitle
         toggleCompletion(cell, isCompleted: isCompleted)
    
         return cell
     }
     
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             let task = tasks[indexPath.row]
             task.ref?.removeValue()
         }
     }
 }
