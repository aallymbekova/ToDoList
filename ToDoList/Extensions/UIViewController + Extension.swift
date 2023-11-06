//
//  UIViewController + Extension.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

extension UIViewController {

    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
    }

    func createCustomTitleView(userName: String, userImage: UIImageView, userDescription: String, userGender: String) -> UIView {

        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 45)

        let imageUser = userImage
        imageUser.frame = CGRect(x: 8, y: 0, width: 40, height: 40)
        imageUser.layer.cornerRadius = imageUser.frame.size.height / 2
        imageUser.clipsToBounds = true
        imageUser.layer.borderColor = UIColor.black.cgColor
        imageUser.layer.borderWidth = 1
        view.addSubview(imageUser)

        let nameLabel = UILabel()
        nameLabel.text = userName
        nameLabel.textColor = .black
        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 15)
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(nameLabel)
        
        let aboutLabel = UILabel()
        aboutLabel.text = userDescription
        aboutLabel.textColor = .black
        aboutLabel.frame = CGRect(x: 55, y: 15, width: 220, height: 15)
        aboutLabel.font = UIFont.systemFont(ofSize: 10)
        view.addSubview(aboutLabel)
        
        let genderLabel = UILabel()
        genderLabel.text = userGender
        genderLabel.textColor = .black
        genderLabel.frame = CGRect(x: 55, y: 25, width: 220, height: 15)
        genderLabel.font = UIFont.systemFont(ofSize: 7)
        view.addSubview(genderLabel)

        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button.tintColor = .darkColor()
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


}

