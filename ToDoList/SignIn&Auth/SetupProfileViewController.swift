//
//  SetupProfileViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit
import FirebaseAuth

class SetupProfileViewController: UIViewController {

    let welcomLabel = UILabel(text: "Set up profile", color: .darkColor(), font: .gillSans50())

    let fullLabel = UILabel(text: "Full Name", color: .darkColor())
    let aboutLabel = UILabel(text: "About me", color: .darkColor())
    let genderLabel = UILabel(text: "Gender", color: .darkColor())

    let fullNameTextField = OneLineTextField(font: .interSemiBold10())
    let aboutMeTextField = OneLineTextField(font: .interSemiBold10())

    let genderSegmentedControl = UISegmentedControl(first: "Male", second: "Femail", selectedColor: .blueColor(), backgroundColor: .darkColor())

    let gotToListButton = UIButton(title: "Go To Your List", titleColor: .white, backgroundColor: .darkColor(), isShadow: true, cornerRadius: 6)

    let fullImageView = AddPhotoView()
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupConstarints()
        
        gotToListButton.addTarget(self, action: #selector(goToListButtonTapped), for: .touchUpInside)
        
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToListButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                userName: fullNameTextField.text,
                                                avatarImage: fullImageView.circleImageView.image,
                                                description: aboutMeTextField.text,
                                                gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let appuser):
                self.showAlert(with: "Successfully", and: "") {
                    let tabBar = TabBarController(currentUser: appuser)
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        fullImageView.circleImageView.image = image
    }
}

//MARK: - Setup Constraints
extension SetupProfileViewController {

    private func setupConstarints() {

        let fullNameStackView = UIStackView(arrangedSubviews: [fullLabel,
                                                               fullNameTextField],
                                            axis: .vertical,
                                            spacing: 0)

        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutLabel,
                                                              aboutMeTextField],
                                           axis: .vertical,
                                           spacing: 0)

        let genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderSegmentedControl], axis: .vertical, spacing: 10)

        gotToListButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let stackView = UIStackView(arrangedSubviews: [fullNameStackView,
                                                       aboutMeStackView,
                                                       genderStackView,
                                                      gotToListButton
                                                      ],
                                    axis: .vertical,
                                    spacing: 40)

        //translatesAutoresizingMaskIntoConstraints
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        //addSubview
        view.addSubview(fullImageView)
        view.addSubview(welcomLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            welcomLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

    }
}

