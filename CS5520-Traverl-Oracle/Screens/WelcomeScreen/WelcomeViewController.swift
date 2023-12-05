//
//  WelcomeViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/18/23.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    // delay time
    let DELAY_TIME = 1.0
    
    // initialize welcome view
    let welcomeView = WelcomeView()
    
    // firebase authentication
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    // add welcome view to view controller
    override func loadView() {
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add auth state listener with delay
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.DELAY_TIME) {
                if user != nil {
                    self.transitionToHomeScreen()
                } else {
                    self.transitionToLoginPage()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Remove auth state listener
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func transitionToHomeScreen() {
        print("Transition to Home screen.")
        let categoryVC = CategoryViewController()
        let savedStoreVC = SavedStoreViewController()
        let conversationsVC = ConversationsViewController()
        let searchStoreVC = SearchStoreViewController()

        let categoryNavVC = UINavigationController(rootViewController: categoryVC)
        categoryNavVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "house"), tag: 0)

        let savedStoreNavVC = UINavigationController(rootViewController: savedStoreVC)
        savedStoreNavVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "heart"), tag: 1)

        let conversationsNavVC = UINavigationController(rootViewController: conversationsVC)
        conversationsNavVC.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 2)

        let searchStoreNavVC = UINavigationController(rootViewController: searchStoreVC)
        searchStoreNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)

        // Create a tab bar controller and set its view controllers
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [categoryNavVC, savedStoreNavVC, conversationsNavVC, searchStoreNavVC]

        // Transition to the tab bar controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
    }
    
    func transitionToLoginPage() {
        print("Transition to Login screen.")
        let loginViewController = LoginViewController()
        var viewControllers = self.navigationController!.viewControllers
        viewControllers.removeAll()
        viewControllers.append(loginViewController)
        self.navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
