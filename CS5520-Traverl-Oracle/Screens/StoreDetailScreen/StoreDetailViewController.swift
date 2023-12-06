//
//  StoreDetailViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class StoreDetailViewController: UIViewController {
    // current user
    private var user: User?
    // initialize store detail view
    private let storeDetailView = StoreDetailView()
    // store data model
    private let store: Store
    // reviews data model
    private var reviews: [Review] = []
    // saved state
    private var isStoreSaved = false
    // firestore listener
    private var reviewsListener: ListenerRegistration?
    // spinner
    private let childProgressView = ProgressSpinnerViewController()
    

    // Create a symbol configuration for the button icons
    private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
    
    override func loadView() {
        view = storeDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        storeDetailView.tableView.separatorStyle = .none
        setupNavigationBarButtons()
        doTableViewDelegations()
        // setup listener
        setupReviewsListener()
    }

    init(with store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        initializeUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        reviewsListener?.remove()
    }
}

// MARK: - Setups
extension StoreDetailViewController {
    private func setupNavigationBarButtons() {
        // Initialize the buttons
        
        let customTintColor = UIColor(hexString: "#b34538")

        let addReviewButton = UIButton(type: .system)
        addReviewButton.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        addReviewButton.tintColor = customTintColor
        addReviewButton.addTarget(self, action: #selector(addReviewButtonTapped), for: .touchUpInside)

        let saveStoreButton = UIButton(type: .system)
        saveStoreButton.setImage(UIImage(systemName: "heart"), for: .normal)
        saveStoreButton.tintColor = customTintColor
        saveStoreButton.addTarget(self, action: #selector(saveStoreButtonTapped), for: .touchUpInside)


        // Create a container view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))

        // Add buttons to the container view
        containerView.addSubview(addReviewButton)
        containerView.addSubview(saveStoreButton)

        // Set frames or constraints for buttons
        addReviewButton.frame = CGRect(x: 0, y: 0, width: 60, height: 45)
        saveStoreButton.frame = CGRect(x: addReviewButton.frame.width, y: 0, width: 30, height: 45)

        // Use the container view to create a single UIBarButtonItem
        let barButtonItem = UIBarButtonItem(customView: containerView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
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
                self?.initializeIsStoreSaved()
            case .failure(let error):
                print("Error fetching user details: \(error)")
            }
        }
    }
    
    private func initializeIsStoreSaved() {
        if let user = user {
            isStoreSaved = user.savedStoreIds.contains(store.id)
            updateSaveStoreButtonAppearance()
        } else {
            print("StoreDetailViewController (initializeIsStoreSaved): User info retrieved failed")
        }
    }
}

// MARK: - Add new review
extension StoreDetailViewController {
    @objc func addReviewButtonTapped() {
        guard let user = user else {
            print("Error(StoreDetailViewController): user was not found when transition to add review screen.")
            return
        }
        print("Transition to add review screen")
        navigationController?.pushViewController(AddReviewViewController(with: user, with: store),
                                                 animated: true)
    }
}

// MARK: - Save store management
extension StoreDetailViewController {
    @objc func saveStoreButtonTapped() {
        guard let user = user else { return }
        print("Save store button tapped")
        var currentUser = user
        self.showActivityIndicator()
        if isStoreSaved {
            // Remove the store from saved stores
            DBManager.dbManager.removeStoreFromSaved(for: user.uid, storeId: store.id) { [weak self] success in
                self?.hideActivityIndicator()
                if success {
                    self?.isStoreSaved = false
                    self?.updateSaveStoreButtonAppearance()
                    currentUser.savedStoreIds.removeAll(where: { $0 == self?.store.id })
                    print("Store removed from saved stores")
                } else {
                    print("Failed to remove store from saved stores")
                }
            }
        } else {
            // Add the store to saved stores
            DBManager.dbManager.addStoreToSaved(for: user.uid, storeId: store.id) { [weak self] success in
                self?.hideActivityIndicator()
                if success {
                    self?.isStoreSaved = true
                    self?.updateSaveStoreButtonAppearance()
                    currentUser.savedStoreIds.append((self?.store.id)!)
                    print("Store added to saved stores")
                } else {
                    print("Failed to add store to saved stores")
                }
            }
        }
    }
    
    private func updateSaveStoreButtonAppearance() {
        let saveStoreButtonImageName = isStoreSaved ? "heart.fill" : "heart"
        if let saveStoreButton = (navigationItem.rightBarButtonItem?.customView as? UIView)?.subviews[1] as? UIButton {
            saveStoreButton.setImage(UIImage(systemName: saveStoreButtonImageName, withConfiguration: symbolConfig)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
}


// MARK: - Data model management
extension StoreDetailViewController {
    // MARK: - Actively listening for new reviews
    private func setupReviewsListener() {
        reviewsListener = DBManager.dbManager.database
            .collection(DBManager.dbManager.STORE_COLLECTION)
            .document(store.id)
            .collection(DBManager.dbManager.REVIEWS_SUBCOLLECTION)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting reviews at reviewsListener: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach { change in
                    if change.type == .added {
                        if let newReview = try? change.document.data(as: Review.self) {
                            self.reviews.append(newReview)
                            self.storeDetailView.tableView.reloadSections(IndexSet(integer: 2),
                                                                          with: .automatic)
                        }
                    }
                }
            }
    }
}

// MARK: - Screen transitions
extension StoreDetailViewController {
    private func transitionToReviewDetailScreen(for review: Review) {
        guard let thisUser = user else { return }
        self.showActivityIndicator()
        DBManager.dbManager.getUser(withUID: review.senderId) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let reviewSender):
                self?.navigationController?.pushViewController(ReviewDetailViewController(review: review,
                                                                                          thisUser: thisUser,
                                                                                          thatUser: reviewSender),
                                                         animated: true)
            case .failure(let error):
                AlertUtil.showErrorAlert(viewController: self!, title: "Error!", errorMessage: "Fetching sender profile failed. Please try again!")
                print("Error fetching review sender's details: \(error)")
            }
        }
    }
}
 
// MARK: - UITableViewDataSource
extension StoreDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func doTableViewDelegations() {
        storeDetailView.tableView.delegate = self
        storeDetailView.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // we define three sections in the store detail view screen
        // section 1: image carousel
        // section 2: store description + extra information
        // section 3: reviews
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // image carousel has only one row
            return 1
        case 1:
            // store description + extra info has only one row
            return 1
        case 2:
            // reviews
            // TODO: replace with the real data source
            return reviews.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: implement configurations if necessary
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCarouselTableViewCell.IDENTIFIER,
                                                     for: indexPath) as! ImageCarouselTableViewCell
            cell.configure(with: store.images) // configure image carousel with image urls
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreDescriptionTableViewCell.IDENTIFIER,
                                                     for: indexPath) as! StoreDescriptionTableViewCell
            cell.configure(with: store)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.IDENTIFIER,
                                                    for: indexPath) as! ReviewsTableViewCell
            cell.configure(with: reviews[indexPath.row])
            return cell
        default:
            fatalError("Unhandled section \(indexPath.section)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            transitionToReviewDetailScreen(for: reviews[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.size.width / 2
        case 1:
            // TODO: set height
            // Height for the store description + extra information cell
            return UITableView.automaticDimension
        case 2:
            // TODO: set height
            // Height for the reviews cell
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat.leastNonzeroMagnitude
        default:
            return Constants.VERTICAL_MARGIN_LARGE
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            // TODO: replace the mocked value with the real data model - DONE
            _ = UIElementUtil.createAndAddLabel(to: headerView,
                                                text: store.displayName.localizedCapitalized,
                                                fontSize: Constants.FONT_REGULAR,
                                                isCenterAligned: false,
                                                isBold: true,
                                                textColor: .black)
            return headerView
        case 2:
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            _ = UIElementUtil.createAndAddLabel(to: headerView,
                                                text: "Reviews",
                                                fontSize: Constants.FONT_REGULAR,
                                                isCenterAligned: false,
                                                isBold: true,
                                                textColor: .black)
            return headerView
        default:
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }
    }
}

// MARK: - Spinner
extension StoreDetailViewController: ProgressSpinnerDelegate {
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
