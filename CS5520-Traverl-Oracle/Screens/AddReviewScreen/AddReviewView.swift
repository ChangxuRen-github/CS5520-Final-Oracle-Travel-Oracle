//
//  AddReviewView.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/25/23.
//

import UIKit

class AddReviewView: UIView {
    var addReviewLabel: UILabel!
    var addReviewTextView: UITextView!
    var addReviewButton: UIButton!
    var starsContainer: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUIComponents()
        setupUIStackView()
        createStars()
        initConstraints()
    }
    
    func setupUIComponents() {
        addReviewLabel = UIElementUtil.createAndAddLabel(to: self, text: "Add a Review", fontSize: Constants.FONT_REGULAR, isCenterAligned: false, isBold: true, textColor: .black)
        
        addReviewTextView = UIElementUtil.createAndAddTextView(to: self, text: "Enter your review here...", fontSize: Constants.FONT_SMALL, isEditable: true, isScrollable: true)
        addReviewTextView.textColor = UIColor.lightGray
        addReviewTextView.layer.borderColor = UIColor.gray.cgColor // the color of the edge
        addReviewTextView.layer.borderWidth = 1.0  //the width of the edge
        addReviewTextView.layer.cornerRadius = 9.0  //the radius of the edge
        
        addReviewButton = UIElementUtil.createAndAddButton(to: self, title: "Add review", color: .red, titleColor: .white)
        addReviewButton.backgroundColor = .init(hexString: "#b34538")
    }
    
    func setupUIStackView() {
        starsContainer = UIStackView()
        starsContainer.axis = .horizontal
        starsContainer.distribution = .fill  // Aligns the stars to the left
        starsContainer.spacing = 5  // Keeps the spacing equal
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(starsContainer)
    }

    
    func createStars() {
        // loop through the number of our stars and add them to the stackView (starsContainer)
        for index in 1...5 {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    
    func makeStarIcon() -> UIImageView {
        // Use system images for stars
        let imageView = UIImageView(image: UIImage(systemName: "star"), highlightedImage: UIImage(systemName: "star.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = UIColor(hexString: "#b34538")
        
        imageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        // size for star
        imageView.widthAnchor.constraint(equalToConstant: Constants.HORIZONTAL_MARGIN_LARGE).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.HORIZONTAL_MARGIN_LARGE).isActive = true

        return imageView
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            // addReviewLabel constraints
            addReviewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            addReviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            addReviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.HORIZONTAL_MARGIN_SMALL),

            // starsContainer constraints
            starsContainer.topAnchor.constraint(equalTo: addReviewLabel.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            starsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            
            // addNoteTextView constraints
            addReviewTextView.topAnchor.constraint(equalTo: starsContainer.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_REGULAR),
            addReviewTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            addReviewTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.HORIZONTAL_MARGIN_SMALL),
            addReviewTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 350),

            // addReviewButton constraints
            addReviewButton.topAnchor.constraint(equalTo: addReviewTextView.bottomAnchor, constant: 200),
            addReviewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            addReviewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.HORIZONTAL_MARGIN_SMALL),
            addReviewButton.heightAnchor.constraint(equalToConstant: Constants.HORIZONTAL_MARGIN_LARGE),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
