//
//  TestViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/24/23.
//

import UIKit

class TestViewController: UIViewController {
    
    let testView = TestView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var sfSymbols: [String]!
    var imageArray: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetToButtons()
        setupSampleImageArray()
    }

    override func loadView() {
        view = testView
    }
    
    func setupSampleImageArray() {
        // Define an array of SF Symbols names
        sfSymbols = ["house.fill", "car.fill", "leaf.fill"]
        // Create UIImage array from SF Symbols
        imageArray = sfSymbols.compactMap { UIImage(systemName: $0) }
    }
    
    // sample store
    let sampleStore = Store(
        id: "A8724698-1657-4A4D-8394-3509ABB45AD0", // unique identifier
        createdAt: nil, // will be set on the server side
        createdBy: "user123", // example user ID
        displayName: "My Sample Store",
        description: "This is a sample store description.",
        price: "$$",
        category: Constants.STORE_CATEGORY_COFEE_SHOP,
        images: [], // initially empty, will be filled after image upload
        tag: Tag(
            goodForBreakfast: "Yes",
            goodForLunch: "Yes",
            goodForDinner: "No",
            takesReservations: "No",
            vegetarianFriendly: "Yes",
            cuisine: "Italian",
            liveMusic: "No",
            outdoorSeating: "Yes",
            freeWIFI: "Yes"
        ),
        location: ""
    )
}

// - Action listener
extension TestViewController {
    func addTargetToButtons() {
        testView.testSaveStoreButton.addTarget(self,
                                               action: #selector(onTestSaveStoreButtonTapped),
                                               for: .touchUpInside)
        
        testView.testStoreDetailScreenButton.addTarget(self,
                                                       action: #selector(onTestStoreDetailScreenButtonTapped),
                                                       for: .touchUpInside)
        
        testView.testSavedStoreScreenButton.addTarget(self,
                                                      action: #selector(onTestSavedStoreScreenButtonTapped),
                                                      for: .touchUpInside)
    }
    
    @objc func onTestSaveStoreButtonTapped() {
        print("Test Save Store Button Tapped.")
        self.showActivityIndicator()
        DBManager.dbManager.addStore(with: sampleStore, with: imageArray) { result in
            self.hideActivityIndicator()
            switch result {
            case .success(let store):
                print("Store added successfully: \(store)")
            case .failure(let error):
                print("Error adding store: \(error)")
            }
        }
    }
    
    @objc func onTestStoreDetailScreenButtonTapped() {
        let storeDetailViewController = StoreDetailViewController(with: sampleStore)
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
    
    @objc func onTestSavedStoreScreenButtonTapped() {
        let saveStoreViewController = SavedStoreViewController()
        navigationController?.pushViewController(saveStoreViewController, animated: true)
    }
}

// - Spinner
extension TestViewController: ProgressSpinnerDelegate {
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
