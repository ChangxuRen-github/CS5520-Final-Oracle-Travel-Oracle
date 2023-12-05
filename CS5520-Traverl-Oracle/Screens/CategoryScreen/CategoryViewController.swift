//
//  CategoryViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class CategoryViewController: UIViewController {
    // Initialize the category view
    private let categoryView = CategoryView()
    // current user
    private var user: User?
    // spinner
    private let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUser()
        setupNavBar()
        addTargetToButtons()
    }
}

// MARK: - Setups
extension CategoryViewController {
    private func initializeUser() {
        guard let uwUser = AuthManager.shared.currentUser else {
            AlertUtil.showErrorAlert(viewController: self,
                                     title: "Error!",
                                     errorMessage: "Please sign in.")
            return
        }
        self.showActivityIndicator()
        DBManager.dbManager.getUser(withUID: uwUser.uid) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                print("Error fetching user details: \(error)")
            }
        }
    }
    
    private func setupNavBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Collections"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(onAddPlaceButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onProfileButtonTapped))
    }
    
    private func addTargetToButtons() {
        categoryView.restaurantButton.addTarget(self, action: #selector(restaurantButtonTapped), for: .touchUpInside)
        categoryView.coffeeShopButton.addTarget(self, action: #selector(coffeeShopButtonTapped), for: .touchUpInside)
        categoryView.shoppingButton.addTarget(self, action: #selector(shoppingButtonTapped), for: .touchUpInside)
        categoryView.barButton.addTarget(self, action: #selector(barButtonTapped), for: .touchUpInside)
        categoryView.hairSalonButton.addTarget(self, action: #selector(hairSalonButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Action listeners
extension CategoryViewController {
    // category buttons
    @objc func restaurantButtonTapped() {
        transitionToStoreListScreen(with: Constants.STORE_CATEGORY_RESTAURANT + "s",
                                    with: Constants.STORE_CATEGORY_RESTAURANT)
    }

    @objc func coffeeShopButtonTapped() {
        transitionToStoreListScreen(with: Constants.STORE_CATEGORY_COFEE_SHOP + "s",
                                    with: Constants.STORE_CATEGORY_COFEE_SHOP)
    }

    @objc func shoppingButtonTapped() {
        transitionToStoreListScreen(with: Constants.STORE_CATEGORY_SHOPPING,
                                    with: Constants.STORE_CATEGORY_SHOPPING)
    }

    @objc func barButtonTapped() {
        transitionToStoreListScreen(with: Constants.STORE_CATEGORY_BAR + "s",
                                    with: Constants.STORE_CATEGORY_BAR)
    }

    @objc func hairSalonButtonTapped() {
        transitionToStoreListScreen(with: Constants.STORE_CATEGORY_HAIR_SALON + "s",
                                    with: Constants.STORE_CATEGORY_HAIR_SALON)
    }
    
    @objc func onProfileButtonTapped() {
        transitionToMyProfileScreen()
    }
    
    @objc func onAddPlaceButtonTapped() {
        transitionToAddPlaceScreen()
    }
}

// MARK: - Screen navigation management
extension CategoryViewController {
    // store list screen
    private func transitionToStoreListScreen(with title: String, with category: String) {
        let storeListViewController = StoreListViewController(with: title, with: category)
        navigationController?.pushViewController(storeListViewController, animated: true)
    }
    
    // my profile screen
    private func transitionToMyProfileScreen() {
        print("Transition to my profile screen.")
        let myProfileViewController = MyProfileViewController()
        navigationController?.pushViewController(myProfileViewController, animated: true)
    }
    
    // add new store screen
    private func transitionToAddPlaceScreen() {
        print("Transition to add place screen.") 
        // TODO: transition to add place screen - Done
        guard let uwUser = user else { return }
        let addPlaceViewController = AddPlaceViewController(with: uwUser)
        present(UINavigationController(rootViewController: addPlaceViewController), animated: true)
    }
}

// MARK: - Spinner
extension CategoryViewController: ProgressSpinnerDelegate {
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
