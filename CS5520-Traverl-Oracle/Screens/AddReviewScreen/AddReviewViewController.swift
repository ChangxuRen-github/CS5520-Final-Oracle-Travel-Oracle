//
//  AddReviewViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/25/23.
//

import UIKit

class AddReviewViewController: UIViewController {
    // initialize add review view
    private let addReviewView = AddReviewView()
    // current user
    private let user: User
    // store that we add review to
    private let store: Store
    // data model that saves the selected rate
    private var selectedRate: Int = 0
    // Adding a selection feedback effect to clicking on a star
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    // spinner
    private let childProgressView = ProgressSpinnerViewController()
    
    
    override func loadView() {
        view = addReviewView
    }
    
    init(with user: User, with store: Store) {
        self.user = user
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReviewView.addReviewTextView.delegate = self
        setupButtons()
        // Adding a UITapGestureRecognizer to our stack of stars to handle clicking on a star
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        addReviewView.starsContainer.addGestureRecognizer(tapGesture)
        // initilize star is 5
        updateStarRatings(5)
    }
    
    
    // TODO: add addReview logic here - DONE C.Ren
    @objc func onAddReviewButtonTapped() {
        // make sure user cannot tpye space
        let reviewText = addReviewView.addReviewTextView.text ?? ""
        let trimmedText = reviewText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // only include "Enter your review here..." will has error
        if trimmedText.isEmpty || trimmedText == "Enter your review here..." {
            AlertUtil.showErrorAlert(viewController: self, title: "Error", errorMessage: "Review cannot be empty. Please enter your feedback.")
            return
        }
        
        // TODO: consider upload a default project image here, and use that as the fallback - DONE C.Ren
        let newReview = Review(senderId: user.uid,
                               senderName: user.displayName,
                               senderProfileImageURL: user.profileImageURL ?? Constants.DEFAULT_PROFILE_IMAGE_URL,
                               storeRating: selectedRate,
                               content: trimmedText)
        self.showActivityIndicator()
        DBManager.dbManager.addNewReview(with: newReview, with: store) { success in
            self.hideActivityIndicator()
            if success {
                print("Review successfully added.")
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Failed to add review.")
                AlertUtil.showErrorAlert(viewController: self, title: "Error", errorMessage: "Errors happened while adding the review. Please try again!")
            }
        }
    }
}

// MARK: - Setup methods
extension AddReviewViewController {
    func setupButtons() {
        addReviewView.addReviewButton.addTarget(self, action: #selector(onAddReviewButtonTapped), for: .touchUpInside)
    }
    
    func updateStarRatings(_ rate: Int) {
        selectedRate = rate
        feedbackGenerator.selectionChanged()
        for (index, view) in addReviewView.starsContainer.arrangedSubviews.enumerated() {
            if let starImageView = view as? UIImageView {
                starImageView.isHighlighted = index < rate
            }
        }
    }
    
    @objc func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: addReviewView.starsContainer)
        let starWidth = addReviewView.starsContainer.bounds.width / CGFloat(5)
        var rate = Int(location.x / starWidth) + 1
        rate = min(rate, 5) // Ensure rate does not exceed 5
        
        if rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        
        addReviewView.starsContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
        }
    }
}

// MARK: - UITextViewDelegate
extension AddReviewViewController: UITextViewDelegate {
    @objc(textView:shouldChangeTextInRange:replacementText:) func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        let wordCount = updatedText.split { $0.isWhitespace }.count
        if wordCount <= 50 {
            return true
        } else {
            AlertUtil.showErrorAlert(viewController: self, title: "Attention", errorMessage: "120 words limit exceeds.")
            return false
        }
    }
    
    // when user click the textfiled, the default word will disappear
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your review here..." // Placeholder text
            textView.textColor = UIColor.lightGray
        }
    }
}

// MARK: - Spinner
extension AddReviewViewController: ProgressSpinnerDelegate {
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
