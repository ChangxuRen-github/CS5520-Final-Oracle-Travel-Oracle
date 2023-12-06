//
//  OthersProfileViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/30/23.
//

import UIKit
import SDWebImage

class OthersProfileViewController: UIViewController {
    // initialize profile view
    private let profileView = OthersProfileView()
    // current user
    private let thisUser: User
    // other user
    private let thatUser: User
    // spinner
    private let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = profileView
    }

    // initialize view controller with two users
    init(thisUser: User, thatUser: User) {
        self.thisUser = thisUser
        self.thatUser = thatUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        displayUserProfile()
        addTargetToButtons()
    }
}

// MARK: - Setups
extension OthersProfileViewController {
    func setupNavBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "User Profile"
    }
    
    func displayUserProfile() {
        profileView.nameLabel.text = "\(thatUser.displayName)"
        profileView.emailLabel.text = "\(thatUser.email)"
        profileView.memberSinceLabel.text = "\(DateFormatter.formatDate(thatUser.createdAt))"
        guard let url = URL(string: thatUser.profileImageURL ?? Constants.DEFAULT_PROFILE_IMAGE_URL) else { return }
        profileView.profileImage.sd_setImage(with: url)
    }
}

// MARK: - Action listeners
extension OthersProfileViewController {
    func addTargetToButtons() {
        profileView.messageButton.addTarget(self, action: #selector(onMessageButtonTapped), for: .touchUpInside)
    }
    
    @objc func onMessageButtonTapped() {
        print("Send message button tapped.")
        DBManager.dbManager.getConversationBetween(with: thisUser, with: thatUser) { result in
            switch result {
            case .success(let conversation):
                print("Conversation retrieved or created successfully: \(conversation)")
                self.transitionToConversationScreen(with: self.thisUser, with: self.thatUser, with: conversation)
            case .failure(let error):
                print("Conversation retrieved or created failed with error: \(error)")
            }
        }
    }
}

// MARK: - Transition between screens
extension OthersProfileViewController {
    func transitionToConversationScreen(with thisUser: User, with thatUser: User, with conversation: Conversation) {
        let conversationViewController = ConversationViewController(with: thisUser, with: thatUser, with: conversation)
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
}

// MARK: - Spinner
extension OthersProfileViewController: ProgressSpinnerDelegate {
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

// TODO: - C.Ren Check if the current user == other user before we initilize the OthersProfileViewController
