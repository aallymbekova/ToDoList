//
//  NewTaskListViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit
import Firebase

class NewTaskViewController: UIViewController {

    var textField = InsertableTextField()

    let addTaskButton = UIButton(title: "Add task",
                                 titleColor: .white,
                                 backgroundColor: .blueColor(),
                                 isShadow: true,
                                 cornerRadius: 2)
    
    private let currentUser: AppUser

    init(currentUser: AppUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.userName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        guard let textField = textField.text, textField != "" else { return }
        PostService.shared.newTaks(text: textField) {[weak self] error, ref in
            self?.tabBarController?.selectedIndex = 0
            self?.textField.text = ""
        }

    }

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
