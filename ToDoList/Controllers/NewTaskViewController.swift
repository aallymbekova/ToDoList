//
//  NewTaskListViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class NewTaskViewController: UIViewController {

    var textField = InsertableTextField()

    let addTaskButton = UIButton(title: "Add task",
                                 titleColor: .white,
                                 backgroundColor: .blueColor(),
                                 isShadow: true,
                                 cornerRadius: 2)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupConstraints()
        setupViews()
        
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
         createCustomNavigationBar()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let signOutRightButton = createCustomButton(imageName: "pip.exit", selector: #selector(signOutRightButtonTapped))

        navigationItem.rightBarButtonItem = signOutRightButton
     }
    
}

//MARK: - Actions

extension NewTaskViewController {
    
    @objc private func addTaskButtonTapped() {
        print(#function)

    }

    @objc private func signOutRightButtonTapped() {
        print(#function)
    }
}

//MARK: - Setup Constaraints

extension NewTaskViewController {
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)
        view.addSubview(addTaskButton)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            addTaskButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            addTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}

