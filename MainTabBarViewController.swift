//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 16.09.2023.
//

import UIKit
import FirebaseAuth

class MainTabBarViewController: UITabBarController {
    //MARK: - Properties
    let pastTaskViewController = PastTaskViewController()
    let taskViewController = TasksViewController()
    let profileViewController = ProfileViewController()
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        userStatus()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        style()
        fetchUser()
    }
}
//MARK: - Selector
extension MainTabBarViewController {
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        TaskService.fetchUser(uid: uid) { user in
            self.taskViewController.user = user
            self.pastTaskViewController.user = user
            self.profileViewController.user = user
        }
    }
}
//MARK: - Helpers
extension MainTabBarViewController {
    private func style() {
        viewControllers = [configureViewController(rootViewController: pastTaskViewController, title: "Past", image: "clock.badge.checkmark"),
                           configureViewController(rootViewController: taskViewController, title: "Tasks", image: "checkmark.circle"),
                           configureViewController(rootViewController: profileViewController, title: "Profile", image: "person.circle")
        ]
        configureTabBar()
    }
    private func userStatus() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }else {
            print("There is a user.")
        }
    }
    private func signOut() {
        do {
            try Auth.auth().signOut()
            userStatus()
        }catch {
            
        }
    }
    private func configureViewController(rootViewController: UIViewController, title: String, image: String) -> UINavigationController{
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        return controller
    }
    private func configureTabBar() {
        let shape = CAShapeLayer()
        let bezier = UIBezierPath(roundedRect: CGRect(x: 10, y: (self.tabBar.bounds.minY) - 16, width: (self.tabBar.bounds.width) - 20 , height: (self.tabBar.bounds.height) + 28), cornerRadius: (self.tabBar.bounds.height) / 1.5)
        shape.path = bezier.cgPath
        shape.fillColor = UIColor.white.cgColor
        self.tabBar.itemPositioning = .fill
        self.tabBar.itemWidth = ((self.tabBar.bounds.width) - 20) / 5
        self.tabBar.tintColor = UIColor.systemPurple.withAlphaComponent(0.7)
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.layer.insertSublayer(shape, at: 0)
        selectedIndex = 1
    }
}
