//
//  StoreDescriptionTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit

class StoreDescriptionTableViewCell: UITableViewCell {
    static let IDENTIFIER: String = "StoreDescription"
    let CELL_HEIGHT: CGFloat = 25
    
    var wrapperCellView: UITableView!
    var storeDescriptionLabel: UILabel!
    var extraInfoLabel: UILabel!
    var priceTitleLabel: UILabel!
    var priceValueLabel: UILabel!
    var freeWIFITitleLabel: UILabel!
    var freeWIFIValueLabel: UILabel!
    var outdoorSeatingTitleLabel: UILabel!
    var outdoorSeatingValueLabel: UILabel!
    var goodForBreakfastTitleLabel: UILabel!
    var goodForBreakfastValueLabel: UILabel!
    var goodForLunchTitleLabel: UILabel!
    var goodForLunchValueLabel: UILabel!
    var goodForDinnerTitleLabel: UILabel!
    var goodForDinnerValueLabel: UILabel!
    var vegetarianFriendlyTitleLabel: UILabel!
    var vegetarianFriendlyValueLabel: UILabel!
    var takesReservationsTitleLabel: UILabel!
    var takesReservationsValueLabel: UILabel!
    var liveMusicTitleLabel: UILabel!
    var liveMusicValueLabel: UILabel!
    var cuisineTitleLabel: UILabel!
    var cuisineValueLabel: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
        initConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUIElements() {
        wrapperCellView = UIElementUtil.createAndAddTablesView(to: self)
        storeDescriptionLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                                text: "Store description is loading...",
                                                                fontSize: Constants.FONT_SMALL,
                                                                isCenterAligned: false,
                                                                isBold: false,
                                                                textColor: .lightGray)
        storeDescriptionLabel.numberOfLines = 0
        extraInfoLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                         text: "Extra info",
                                                         fontSize: Constants.FONT_REGULAR,
                                                         isCenterAligned: false,
                                                         isBold: true,
                                                         textColor: .black)
        priceTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Price",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        priceValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        freeWIFITitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Free Wi-Fi",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        freeWIFIValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        outdoorSeatingTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Outdoor Seating",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        outdoorSeatingValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        goodForBreakfastTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Good for Breakfast",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        goodForBreakfastValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)

        goodForLunchTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Good for Lunch",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        goodForLunchValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        goodForDinnerTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Good for Dinner",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        goodForDinnerValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        vegetarianFriendlyTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Vegetarian Friendly",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        vegetarianFriendlyValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        takesReservationsTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Takes Reservations",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        takesReservationsValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        liveMusicTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Live Music",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        liveMusicValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
        cuisineTitleLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Cuisine",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: .black)
        cuisineValueLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "N/A",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: false,
                                                             textColor: .lightGray)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            storeDescriptionLabel.topAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.topAnchor,
                                                       constant: Constants.VERTICAL_MARGIN_REGULAR),
            storeDescriptionLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                           constant: Constants.HORIZONTAL_MARGIN_TINY),
            storeDescriptionLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                            constant: -Constants.HORIZONTAL_MARGIN_TINY),
            storeDescriptionLabel.heightAnchor.constraint(equalToConstant: 80),
            
            
            extraInfoLabel.topAnchor.constraint(equalTo: storeDescriptionLabel.bottomAnchor,
                                                constant: Constants.VERTICAL_MARGIN_LARGE),
            extraInfoLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.HORIZONTAL_MARGIN_TINY),
            extraInfoLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                            constant: -Constants.HORIZONTAL_MARGIN_TINY),
            extraInfoLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            priceTitleLabel.topAnchor.constraint(equalTo: extraInfoLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_REGULAR),
            priceTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            priceTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            priceValueLabel.topAnchor.constraint(equalTo: extraInfoLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_REGULAR),
            priceValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            priceValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            priceValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            freeWIFITitleLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            freeWIFITitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            freeWIFITitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            freeWIFIValueLabel.topAnchor.constraint(equalTo: priceValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            freeWIFIValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            freeWIFIValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            freeWIFIValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            outdoorSeatingTitleLabel.topAnchor.constraint(equalTo: freeWIFITitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            outdoorSeatingTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            outdoorSeatingTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            outdoorSeatingValueLabel.topAnchor.constraint(equalTo: freeWIFIValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            outdoorSeatingValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            outdoorSeatingValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            outdoorSeatingValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            goodForBreakfastTitleLabel.topAnchor.constraint(equalTo: outdoorSeatingTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForBreakfastTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            goodForBreakfastTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            goodForBreakfastValueLabel.topAnchor.constraint(equalTo: outdoorSeatingValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForBreakfastValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            goodForBreakfastValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            goodForBreakfastValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            goodForLunchTitleLabel.topAnchor.constraint(equalTo: goodForBreakfastTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForLunchTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            goodForLunchTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            goodForLunchValueLabel.topAnchor.constraint(equalTo: goodForBreakfastValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForLunchValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            goodForLunchValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            goodForLunchValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            
            goodForDinnerTitleLabel.topAnchor.constraint(equalTo: goodForLunchTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForDinnerTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            goodForDinnerTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            goodForDinnerValueLabel.topAnchor.constraint(equalTo: goodForLunchValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            goodForDinnerValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            goodForDinnerValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            goodForDinnerValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            
            vegetarianFriendlyTitleLabel.topAnchor.constraint(equalTo: goodForDinnerTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            vegetarianFriendlyTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            vegetarianFriendlyTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            vegetarianFriendlyValueLabel.topAnchor.constraint(equalTo: goodForDinnerValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            vegetarianFriendlyValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            vegetarianFriendlyValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            vegetarianFriendlyValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            
            takesReservationsTitleLabel.topAnchor.constraint(equalTo: vegetarianFriendlyTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            takesReservationsTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            takesReservationsTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            takesReservationsValueLabel.topAnchor.constraint(equalTo: vegetarianFriendlyValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            takesReservationsValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            takesReservationsValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            takesReservationsValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            
            liveMusicTitleLabel.topAnchor.constraint(equalTo: takesReservationsTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            liveMusicTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            liveMusicTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            liveMusicValueLabel.topAnchor.constraint(equalTo: takesReservationsValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            liveMusicValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            liveMusicValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            liveMusicValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            cuisineTitleLabel.topAnchor.constraint(equalTo: liveMusicTitleLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            cuisineTitleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_SMALL),
            cuisineTitleLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            cuisineValueLabel.topAnchor.constraint(equalTo: liveMusicValueLabel.bottomAnchor,
                                                    constant: Constants.VERTICAL_MARGIN_TINY),
            cuisineValueLabel.leadingAnchor.constraint(equalTo: freeWIFITitleLabel.trailingAnchor,
                                                        constant: Constants.HORIZONTAL_MARGIN_LARGE),
            cuisineValueLabel.trailingAnchor.constraint(equalTo: wrapperCellView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.HORIZONTAL_MARGIN_REGULAR),
            cuisineValueLabel.heightAnchor.constraint(equalToConstant: CELL_HEIGHT),
            
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 16 * CELL_HEIGHT)
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

    public func configure(with model: Store) {
        // TODO: config cell with store model
        priceValueLabel.text = model.price
        storeDescriptionLabel.text = model.description
        freeWIFIValueLabel.text = model.tag.freeWIFI
        outdoorSeatingValueLabel.text = model.tag.outdoorSeating
        goodForBreakfastValueLabel.text = model.tag.goodForBreakfast
        goodForLunchValueLabel.text = model.tag.goodForLunch
        goodForDinnerValueLabel.text = model.tag.goodForDinner
        vegetarianFriendlyValueLabel.text = model.tag.vegetarianFriendly
        takesReservationsValueLabel.text = model.tag.takesReservations
        liveMusicValueLabel.text = model.tag.liveMusic
        cuisineValueLabel.text = model.tag.cuisine
    }
}
