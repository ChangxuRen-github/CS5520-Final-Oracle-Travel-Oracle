//
//  ReviewDetailView.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 12/2/23.
//

import UIKit
import SDWebImage

class ReviewDetailView: UIView {
    let PROFILE_IMAGE_HEIGHT: CGFloat = 50
    let CELL_HEIGHT: CGFloat = 50 / 2
    let STAR_SIZE: CGFloat = 25
    var reviewContentLabel: UILabel!
    var senderNameLabel: UILabel!
    var profilePhoto: UIImageView!
    var starsContainer: UIStackView!
    var onProfileImageTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUIElements()
        setupUIStackView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIElements() {
        reviewContentLabel = UIElementUtil.createAndAddLabel(to: self,
                                                     text: "Review is loading...",
                                                     fontSize: Constants.FONT_REGULAR,
                                                     isCenterAligned: false,
                                                     isBold: false,
                                                     textColor: UIColor.black)
        senderNameLabel = UIElementUtil.createAndAddLabel(to: self,
                                                          text: "Name is loading",
                                                          fontSize: Constants.FONT_REGULAR,
                                                          isCenterAligned: false,
                                                          isBold: true,
                                                          textColor: UIColor.black)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byWordWrapping
        profilePhoto = UIElementUtil.createAndAddImageView(to: self, imageName: "person.crop.square.fill")
        profilePhoto.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profilePhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
        onProfileImageTapped?()
    }
    
    func setupUIStackView() {
        starsContainer = UIStackView()
        starsContainer.axis = .horizontal
        starsContainer.distribution = .fill  // Aligns the stars to the left
        starsContainer.spacing = 5  // Keeps the spacing equal
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(starsContainer)
    }
    
    func createStars(_ rating: Int) {
        // loop through the number of our stars and add them to the stackView (starsContainer)
        for index in 1...5 {
            let star = makeStarIcon(isHighlighted: index <= rating)
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    
    func makeStarIcon(isHighlighted: Bool) -> UIImageView {
        // Use system images for stars
        let imageView = UIImageView(image: isHighlighted ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.tintColor = UIColor(hexString: "#b34538")

        imageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)

        // size for star
        imageView.widthAnchor.constraint(equalToConstant: STAR_SIZE).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: STAR_SIZE).isActive = true

        return imageView
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.VERTICAL_MARGIN_REGULAR),
            profilePhoto.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: Constants.HORIZONTAL_MARGIN_REGULAR),
            profilePhoto.heightAnchor.constraint(equalToConstant: PROFILE_IMAGE_HEIGHT),
            profilePhoto.widthAnchor.constraint(equalToConstant: PROFILE_IMAGE_HEIGHT),
            
            senderNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.VERTICAL_MARGIN_REGULAR),
            senderNameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            senderNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.HORIZONTAL_MARGIN_SMALL),
            senderNameLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            starsContainer.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: Constants.VERTICAL_MARGIN_TINY),
            starsContainer.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            starsContainer.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),

            reviewContentLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: Constants.VERTICAL_MARGIN_REGULAR),
            reviewContentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.HORIZONTAL_MARGIN_REGULAR),
            reviewContentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.HORIZONTAL_MARGIN_SMALL),
        ])
    }
    
    public func configure(with model: Review) {
        guard let url = URL(string: model.senderProfileImageURL) else { return }
        profilePhoto.sd_setImage(with: url, completed: nil)
        senderNameLabel.text = model.senderName
        createStars(model.storeRating)
        reviewContentLabel.text = model.content
    }
}
