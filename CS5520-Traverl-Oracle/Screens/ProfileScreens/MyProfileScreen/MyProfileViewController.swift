//
//  MyProfileViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/30/23.
//

import UIKit

class MyProfileViewController: UIViewController {

    // initialize profile view
    let myProfileView = MyProfileView()

    // spinner
    let childProgressView = ProgressSpinnerViewController()
    
    // current user
    var currentUser: User?
    
    // current image
    var currentProfileImage: UIImage?
    
    override func loadView() {
        view = myProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addTargetToButtons()
        getProfile()
    }
    
    func setupNavBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Your Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(onEditButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#b34538")
    }
    
    func getProfile() {
        guard let uid = AuthManager.shared.uid else {
            AlertUtil.showErrorAlert(viewController: self,
                                     title: "Error!",
                                     errorMessage: "Please sign in.")
            self.transitionToLoginScreen()
            return
        }
        self.showActivityIndicator()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        DBManager.dbManager.getUser(withUID: uid) { result in
            self.hideActivityIndicator()
            switch result {
            case .success(let user):
                print("User retrieved: \(user)")
                // User retrieved, then we fetch profile image from firebase storage
                self.showActivityIndicator()
                DBManager.dbManager.fetchProfileImage(fromURL: user.profileImageURL ?? "") { fetchedImage in
                    self.hideActivityIndicator()
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    if let image = fetchedImage {
                        self.displayProfile(with: user, with: image)
                    } else {
                        AlertUtil.showErrorAlert(viewController: self,
                                                 title: "Error!",
                                                 errorMessage: "Failed to retrieve your profile photo.")
                    }
                }
            case .failure(let error):
                print("Error retrieving user: \(error.localizedDescription)")
                AlertUtil.showErrorAlert(viewController: self,
                                         title: "Error!",
                                         errorMessage: "Failed to retrieve your profile: \(error.localizedDescription)")
            }
        }
    }
    
    func displayProfile(with user: User, with profileImage: UIImage) {
        self.currentUser = user
        self.currentProfileImage = profileImage
        myProfileView.nameLabel.text = "\(user.displayName)"
        myProfileView.emailLabel.text = "\(user.email)"
        myProfileView.memberSinceLabel.text = "\(DateFormatter.formatDate(user.createdAt))"
        myProfileView.profileImage.image = profileImage
    }
}

// MARK: - Action listeners
extension MyProfileViewController {
    
    func addTargetToButtons() {
        myProfileView.logoutButton.addTarget(self, action: #selector(onLogoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func onLogoutButtonTapped() {
        showActivityIndicator()
        AuthManager.shared.signOut{ result in
            hideActivityIndicator()
            switch result {
            case .success():
                print("User successfully log out.")
                print("User sign status: \(AuthManager.shared.isUserSignedIn())")
                self.transitionToLoginScreen()

            case .failure(let error):
                print("Sign out failed: \(error.localizedDescription)")
                AlertUtil.showErrorAlert(viewController: self,
                                         title: "Error!",
                                         errorMessage: "Error: Sign out failed: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func onEditButtonTapped() {
        // TODO: edit init() and initialize edit profile view controller here
        guard let currentUser = self.currentUser, let currentProfileImage = self.currentProfileImage else {
            print("User information retrieved failed.")
            return
        }
        let editProfileViewController = EditProfileViewController(with: currentUser, with: currentProfileImage)
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
}

// MARK: - Transition between screens
extension MyProfileViewController {
    func transitionToLoginScreen() {
        // TODO: implement transtition -Done
        print("Transition to log in screen.")
        let loginViewController = LoginViewController()
        /*
        var viewControllers = self.navigationController!.viewControllers
        viewControllers.removeAll()
        viewControllers.append(loginViewController)
        self.navigationController?.setViewControllers(viewControllers, animated: true)
        */
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UINavigationController(rootViewController: loginViewController)
            window.makeKeyAndVisible()
        }
    }
}

// MARK: - Spinner
extension MyProfileViewController: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
