//
//  SignInViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    let welcomLabel = UILabel(text: "Welcom!", color: .darkColor(), font: .gillSans50())
    let emailLabel = UILabel(text: "Email", color: .darkColor())
    let passwordLabel = UILabel(text: "Password", color: .darkColor())
    let confirmPasswordLabel = UILabel(text: "Confirm password", color: .darkColor())
    let alreadyOnBoardLabel = UILabel(text: "Already on board?", color: .darkColor())
    
    let emailTextField = OneLineTextField(font: .interSemiBold10())
    let passwordTextField = OneLineTextField(font: .interSemiBold10())
    let confirmPasswordTextField = OneLineTextField(font: .interSemiBold10())
    
    let signInButton = UIButton(title: "Sign In", titleColor: .lightColor(), backgroundColor: .darkColor(), isShadow: true , cornerRadius: 4)
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.redColor(), for: .normal)
        button.titleLabel?.font = .interSemiBold10()
        return button
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func signInButtonTapped() {
        AuthService.shared.register(email: emailTextField.text,
                                    password: passwordTextField.text,
                                    confirmPassword: confirmPasswordTextField.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Successfully", and: "You are registered") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }    }
    
    @objc private func loginButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }

}

//MARK: - Setup Constarints

extension SignInViewController {
    
    private func setupConstraints() {
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)

        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)

        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView,
                                                       passwordStackView,
                                                       confirmPasswordStackView,
                                                       signInButton],
                                    axis: .vertical, spacing: 40)
        
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel,
                                                             loginButton],
                                          axis: .horizontal,
                                          spacing: 10)
        
        bottomStackView.alignment = .firstBaseline
        
        welcomLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
        welcomLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
        welcomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 160),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

    }
}

