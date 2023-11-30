//
//  StoreDetailViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit
import FirebaseFirestore

class StoreDetailViewController: UIViewController {
    // initialize store detail view
    private let storeDetailView = StoreDetailView()
    // store data model
    private let store: Store
    // reviews data model
    private var reviews: [Review] = []
    // firestore listener
    private var reviewsListener: ListenerRegistration?
    
    override func loadView() {
        view = storeDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        storeDetailView.tableView.separatorStyle = .none
        doTableViewDelegations()
        // setup listener
        setupReviewsListener()
    }
    
    init(with store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        reviewsListener?.remove()
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
                                                fontSize: Constants.FONT_LARGET,
                                                isCenterAligned: false,
                                                isBold: true,
                                                textColor: .black)
            return headerView
        case 2:
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            _ = UIElementUtil.createAndAddLabel(to: headerView,
                                                text: "Reviews",
                                                fontSize: Constants.FONT_LARGET,
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




// MARK: - Mock data
var mockImages: [String] = [
    "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F04A0C8BC-13A8-484A-8762-B9749263AC3E.jpg?alt=media&token=57369f06-23c0-444a-b12e-462e8200bb87",
    "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F3595F05D-FAFD-4FD9-9154-E99773076435.jpg?alt=media&token=a6e53d68-0c5f-4de9-9e65-124e11c059d1",
    "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F653566A1-B6BD-449A-B35B-E8A9F62614D7.jpg?alt=media&token=f50c5b28-fc67-4d10-ad2a-42dd9e93c968",
    "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6"
]
var mockTag = Tag(goodForBreakfast: "MockValue",
                         goodForLunch: "MockValue",
                         goodForDinner: "MockValue",
                         takesReservations: "MockValue",
                         vegetarianFriendly: "MockValue",
                         cuisine: "MockValue",
                         liveMusic: "MockValue",
                         outdoorSeating: "MockValue",
                         freeWIFI: "MockValue")

var mockStore = Store(id: "mockId",
                               createdBy: "mockUser",
                               displayName: "mockStore",
                               description: "This is a mocked store!!!",
                               price: "$",
                               category: "Bar",
                               images: [
                                "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F04A0C8BC-13A8-484A-8762-B9749263AC3E.jpg?alt=media&token=57369f06-23c0-444a-b12e-462e8200bb87",
                                "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F3595F05D-FAFD-4FD9-9154-E99773076435.jpg?alt=media&token=a6e53d68-0c5f-4de9-9e65-124e11c059d1",
                                "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F653566A1-B6BD-449A-B35B-E8A9F62614D7.jpg?alt=media&token=f50c5b28-fc67-4d10-ad2a-42dd9e93c968",
                                "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6"
                            ],
                               tag: Tag(goodForBreakfast: "MockValue",
                                        goodForLunch: "MockValue",
                                        goodForDinner: "MockValue",
                                        takesReservations: "MockValue",
                                        vegetarianFriendly: "MockValue",
                                        cuisine: "MockValue",
                                        liveMusic: "MockValue",
                                        outdoorSeating: "MockValue",
                                        freeWIFI: "MockValue"))
var mockReviews: [Review] = [
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 3,
           content: "This is a mock review1. It is meaningless."),
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 1,
           content: "This is a mock review2. It is meaningless."),
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 5,
           content: "This is a mock review3. It is meaningless."),
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 5,
           content: "This is a mock review3. It is meaningless."),
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 5,
           content: "This is a mock review3. It is meaningless."),
    Review(senderId: "Mock Reviewer ID",
           senderName: "Mock Reviewer Name",
           senderProfileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/neu-cs5520-travel-oracle.appspot.com/o/StoreImages%2F58C7755B-D4C1-48AE-A114-96D8EA13EDD3.jpg?alt=media&token=5c714c07-0200-4a77-ad0b-11624ef76fa6",
           storeRating: 5,
           content: "This is a mock review3. It is meaningless.")
]
