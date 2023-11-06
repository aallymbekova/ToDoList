//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    var tasks = [""]

     private let tableView: UITableView = {
         let tableView = UITableView()
         tableView.backgroundColor = .white
         return tableView
     }()
     
      private let userImage = UIImageView()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self

         tableView.register(TaskListViewCell.self, forCellReuseIdentifier: TaskListViewCell.reuseId)

         setupConstraints()
         setupViews()
         
     }
 }

//MARK: - Actions

extension TaskListViewController {
    
    @objc private func signOutRightButtonTapped() {
        print(#function)
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
        
         let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        
        let customTitleView = createCustomTitleView(userName: "Ilizar", userImage: imageView, userDescription: "I'm 15", userGender: "")
        let signOutRightButton = createCustomButton(imageName: "pip.exit", selector: #selector(signOutRightButtonTapped))

         navigationItem.titleView = customTitleView
        navigationItem.rightBarButtonItem = signOutRightButton
     }
}
 //MARK: - UITableViewDelegate
 extension TaskListViewController: UITableViewDelegate {

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         44
     }

 }

 //MARK: - UITableViewDataSource
 extension TaskListViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tasks.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: TaskListViewCell.reuseId, for: indexPath) as! TaskListViewCell

         cell.textLabel?.text = tasks[indexPath.row]

         return cell
     }
     
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }
     
 }
