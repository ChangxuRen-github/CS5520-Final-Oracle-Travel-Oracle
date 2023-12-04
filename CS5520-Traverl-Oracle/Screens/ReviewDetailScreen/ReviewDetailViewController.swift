//
//  ReviewDetailViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 12/2/23.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    // initialize review detail view
    private let reviewDetailView = ReviewDetailView()
    // review data model
    private let review: Review
    // current user
    private let thisUser: User
    // other user
    private let thatUser: User
    
    override func loadView() {
        view = reviewDetailView
    }
    
    init(review: Review, thisUser: User, thatUser: User) {
        self.review = review
        self.thisUser = thisUser
        self.thatUser = thatUser
        super.init(nibName: nil, bundle: nil)
        reviewDetailView.configure(with: review)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupImageTapHandler()
    }
}

// MARK: - Setups
extension ReviewDetailViewController {
    func setupNavBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.black,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Review"
    }
    
    func setupImageTapHandler() {
        reviewDetailView.onProfileImageTapped = { [weak self] in
            self?.onProfilePhotoButtonTapped()
        }
    }
}

// MARK: - Action listeners
extension ReviewDetailViewController {
    @objc func onProfilePhotoButtonTapped() {
        print("Transition to other user's profile.")
        // if user clicks on his/her own review
        if thisUser.uid == thatUser.uid { return }
        let othersProfileViewController = OthersProfileViewController(thisUser: thisUser,
                                                                      thatUser: thatUser)
        self.navigationController?.pushViewController(othersProfileViewController,
                                                 animated: true)
    }
}
