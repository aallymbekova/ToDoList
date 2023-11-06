//
//  ViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class AuthViewController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "phone"),
                                contentMode: .scaleAspectFill)
    
    let toDoListLabel = UILabel(text: "To Do List",
                                color: .darkColor(),
                                font: .gillSans50())
    
    let emailLabel = UILabel(text: "Get started with",
                             color: .darkColor())
    
    let loginLabel = UILabel(text: " Or already onboard?",
                             color: .darkColor())
    
    
    let emailButton = UIButton(title: "Email",
                               titleColor: .white,
                               backgroundColor: .darkColor())
    
    let loginButton = UIButton(title: "Login",
                               titleColor: .lightColor(),
                               backgroundColor: .blueColor(),
                               isShadow: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    }
    
    @objc private func emailButtonTapped() {
        print(#function)
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
    }
}
    
    //MARK: - Setup Constarints
    
extension AuthViewController {
    
    private func setupConstraints() {
        
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: loginLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [emailView, loginView], axis: .vertical, spacing: 30)

        //addSubview
        view.addSubview(stackView)
        view.addSubview(toDoListLabel)
        view.addSubview(imageView)
        
        //translatesAutoresizingMaskIntoConstraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        toDoListLabel.translatesAutoresizingMaskIntoConstraints = false
                
        //Anchors
      
        NSLayoutConstraint.activate([
        toDoListLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
        toDoListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 85)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 275),
            imageView.leadingAnchor.constraint(equalTo: toDoListLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: toDoListLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
}


