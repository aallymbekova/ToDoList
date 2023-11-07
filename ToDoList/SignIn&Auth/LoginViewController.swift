//
//  LoginViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

 class LoginViewController: UIViewController {

     let welcomLabel = UILabel(text: "Welcom Back!", color: .darkColor(), font: .gillSans50())
     let emailLabel = UILabel(text: "Email", color: .darkColor())
     let passwordLabel = UILabel(text: "Password", color: .darkColor())
     let needAnAccountLabel = UILabel(text: "Need an account?", color: .darkColor())

     let emailTextField = OneLineTextField(font: .interSemiBold10())
     let passwordTextField = OneLineTextField(font: .interSemiBold10())

     let loginButton = UIButton(title: "Login",
                                titleColor: .lightColor(),
                                backgroundColor: .darkColor(),
                                isShadow: true)

     let signInButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sign in", for: .normal)
         button.setTitleColor(.redColor(), for: .normal)
         button.titleLabel?.font = .interSemiBold10()
         return button
     }()
     
     weak var delegate: AuthNavigationDelegate?
     
     override func viewDidLoad() {
         super.viewDidLoad()

         view.backgroundColor = .white

         setupConstarints()
         
         loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
         
         signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
     }
     
     @objc private func loginButtonTapped() {
         AuthService.shared.login(email: emailTextField.text,
                                  password: passwordTextField.text) { result in
             switch result {
             case .success(let user):
                 self.showAlert(with: "Successfully", and: "You are logged in") {
                     FirestoreService.shared.getUserData(user: user) { result in
                         switch result {
                         case .success(let appuser):
                             let tabBar = TabBarController(currentUser: appuser)
                             tabBar.modalPresentationStyle = .fullScreen
                             self.present(tabBar, animated: true, completion: nil)
                         case .failure(_):
                             self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                         }
                     }
                    
                 }

             case .failure(let error):
                 self.showAlert(with: "Error", and: error.localizedDescription)
             }
         }
         
     }
     
     @objc private func signInButtonTapped() {
         dismiss(animated: true) {
             self.delegate?.toSignInVC()
         }
     }
 }

 //MARK: Setup Constraints
 extension LoginViewController {

     private func setupConstarints() {

         let emailStackView = UIStackView(arrangedSubviews: [emailLabel,
                                                             emailTextField],
                                          axis: .vertical,
                                          spacing: 0)

         let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,
                                                             passwordTextField],
                                          axis: .vertical,
                                          spacing: 0)

         loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
         let stackView = UIStackView(arrangedSubviews: [emailStackView,
                                                       passwordStackView,
                                                       loginButton],
                                     axis: .vertical,
                                     spacing: 40)

         signInButton.contentHorizontalAlignment = .leading
         let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel,
                                                              signInButton],
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
             welcomLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
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

