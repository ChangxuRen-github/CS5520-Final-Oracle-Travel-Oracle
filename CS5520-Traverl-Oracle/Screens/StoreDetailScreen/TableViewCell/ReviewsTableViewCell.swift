//
//  ReviewsTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit
import SDWebImage

class ReviewsTableViewCell: UITableViewCell {
    static let IDENTIFIER: String = "Reviews"
    let CELL_BORDER_WIDTH: CGFloat  = 0
    let CELL_BORDER_RADIUS: CGFloat = 10
    let PROFILE_IMAGE_MARGIN: CGFloat = 13
    let CELL_HEIGHT: CGFloat = 50
    let REVIEW_CELL_HEIGHT: CGFloat = 70
    let STAR_SIZE: CGFloat = 20
    var wrapperCellView: UITableView!
    var reviewContentLabel: UILabel!
    var profilePhoto: UIImageView!
    var starsContainer: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
        setupUIStackView()
        initConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // source: https://www.youtube.com/watch?v=1KILMba7I8Q
        wrapperCellView.frame = wrapperCellView.frame.inset(by: UIEdgeInsets(top: 1.5, left: 1.5, bottom: 1.5, right: 1.5))
    }
    
    func setupUIElements() {
        wrapperCellView = UIElementUtil.createAndAddTablesView(to: self)
        wrapperCellView.layer.borderWidth = CELL_BORDER_WIDTH // 0
        wrapperCellView.layer.cornerRadius = CELL_BORDER_RADIUS // 8
        reviewContentLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                     text: "Review is loading...",
                                                     fontSize: Constants.FONT_SMALL,
                                                     isCenterAligned: false,
                                                     isBold: false,
                                                     textColor: UIColor.black)
        reviewContentLabel.numberOfLines = 3
        reviewContentLabel.lineBreakMode = .byTruncatingTail
        profilePhoto = UIElementUtil.createAndAddImageView(to: wrapperCellView, imageName: "person.crop.square.fill")
        profilePhoto.isUserInteractionEnabled = true // enable user interaction so that users can tap on it
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
        imageView.isUserInteractionEnabled = false //  TODO: remove this, I do not think we need interact for reviews - C.Ren
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
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            profilePhoto.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: Constants.HORIZONTAL_MARGIN_TINY),
            profilePhoto.centerYAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.centerYAnchor),
            profilePhoto.heightAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.heightAnchor,
                                                 constant: -PROFILE_IMAGE_MARGIN),
            profilePhoto.widthAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.heightAnchor,
                                                constant: -PROFILE_IMAGE_MARGIN),
            
            starsContainer.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: Constants.VERTICAL_MARGIN_REGULAR), // 4
            starsContainer.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
 
            reviewContentLabel.topAnchor.constraint(equalTo: starsContainer.bottomAnchor, constant: Constants.VERTICAL_MARGIN_TINY), // 4
            reviewContentLabel.leadingAnchor.constraint(equalTo: starsContainer.leadingAnchor),
            reviewContentLabel.heightAnchor.constraint(equalToConstant: REVIEW_CELL_HEIGHT),
            reviewContentLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                         constant: -Constants.HORIZONTAL_MARGIN_SMALL),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 2 * (CELL_HEIGHT + Constants.VERTICAL_MARGIN_SMALL) + Constants.VERTICAL_MARGIN_REGULAR)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func clearStars() {
        for view in starsContainer.arrangedSubviews {
            starsContainer.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    public func configure(with model: Review) {
        guard let url = URL(string: model.senderProfileImageURL) else { return }
        profilePhoto.sd_setImage(with: url, completed: nil)
        clearStars()
        createStars(model.storeRating)
        reviewContentLabel.text = model.content
    }
}
