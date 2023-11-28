//
//  AddReviewViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/25/23.
//

import UIKit

class AddReviewViewController: UIViewController, UITextViewDelegate {
    
    var addReviewView = AddReviewView()
    
    var selectedRate: Int = 0
    
    // Adding a selection feedback effect to clicking on a star
    let feedbackGenerator = UISelectionFeedbackGenerator()
    
    override func loadView() {
        view = addReviewView
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
    
    func updateStarRatings(_ rate: Int) {
        selectedRate = rate
        feedbackGenerator.selectionChanged()
        
        for (index, view) in addReviewView.starsContainer.arrangedSubviews.enumerated() {
            if let starImageView = view as? UIImageView {
                starImageView.isHighlighted = index < rate
            }
        }
    }
    
    func setupButtons() {
        addReviewView.addReviewButton.addTarget(self, action: #selector(onAddReviewButtonTapped), for: .touchUpInside)
    }
    
    @objc func onAddReviewButtonTapped() {
        // make sure user cannot tpye space
        let reviewText = addReviewView.addReviewTextView.text ?? ""
        let trimmedText = reviewText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // only include "Enter your review here..." will has error
        if trimmedText.isEmpty || trimmedText == "Enter your review here..." {
            showAlert(title: "Error", message: "Review cannot be empty. Please enter your feedback.")
            return
            }
        
        // Assume review is always added successfully
        showAlert(title: "Success", message: "Your review has been added.")
        resetReviewForm()
    }
    
    @objc(textView:shouldChangeTextInRange:replacementText:) func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        let wordCount = updatedText.split { $0.isWhitespace }.count
        if wordCount <= 120 {
                return true
            } else {
                showAlert(title: "Attention", message: "120 words is the limit")
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
    
    // reset Review form
    func resetReviewForm() {
        addReviewView.addReviewTextView.text = ""
        updateStarRatings(5)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
