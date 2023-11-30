//
//  CategoryViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let categoryView = CategoryView()
    
    override func loadView() {
        view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTapOutside()
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Collections"
        
        //TODO: cilck buttons and switch category to different Store List Screen
        categoryView.restaurantButton.addTarget(self, action: #selector(restaurantButtonTapped), for: .touchUpInside)
        categoryView.coffeeShopButton.addTarget(self, action: #selector(coffeeShopButtonTapped), for: .touchUpInside)
        categoryView.shoppingButton.addTarget(self, action: #selector(shoppingButtonTapped), for: .touchUpInside)
        categoryView.barButton.addTarget(self, action: #selector(barButtonTapped), for: .touchUpInside)
        categoryView.hairSalonButton.addTarget(self, action: #selector(hairSalonButtonTapped), for: .touchUpInside)
    }
    
    @objc func restaurantButtonTapped() {
        navigateToStoreList(withTitle: "Restaurants", fontSize: Constants.FONT_SMALL)
    }

    @objc func coffeeShopButtonTapped() {
        navigateToStoreList(withTitle: "Coffee Shops", fontSize: Constants.FONT_SMALL)
    }

    @objc func shoppingButtonTapped() {
        navigateToStoreList(withTitle: "Shopping", fontSize: Constants.FONT_SMALL)
    }

    @objc func barButtonTapped() {
        navigateToStoreList(withTitle: "Bars", fontSize: Constants.FONT_SMALL)
    }

    @objc func hairSalonButtonTapped() {
        navigateToStoreList(withTitle: "Hair Salons", fontSize: Constants.FONT_SMALL)
    }
    
    func navigateToStoreList(withTitle title: String, fontSize: CGFloat) {
        // create the controller view needs to be reached
        let storeListViewController = StoreListViewController()
        storeListViewController.pageTitle = title
        storeListViewController.pageTitleFontSize = fontSize
        navigationController?.pushViewController(storeListViewController, animated: true)
        }
    
    func hideKeyboardOnTapOutside() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
}
