//
//  TabBarViewController.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskListVC = TaskListViewController()
        let newTaskVC = NewTaskViewController()
        
        tabBar.tintColor = .darkColor()
        let taskListImage = UIImage(systemName: "doc.fill")!
        let newTaskImage = UIImage(systemName: "doc.fill.badge.plus")!
        
        viewControllers = [
        
            generateNavigationController(rootViewController: taskListVC, title: "Tasks", image: taskListImage),
            generateNavigationController(rootViewController: newTaskVC, title: "Add task", image: newTaskImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}