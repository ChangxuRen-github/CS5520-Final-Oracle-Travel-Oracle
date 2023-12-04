//
//  SearchStoreTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 12/3/23.
//

import UIKit

class SearchStoreTableViewCell: UITableViewCell {
    static let IDENTIFIER: String = "SearchStoresCell"
    var wrapperCellView: UITableView!
    var storeDisplayNameLabel: UILabel!
    var storeCreatedAtLabel: UILabel!
    var storeCategoryLabel: UILabel!
    var imageReceipt: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
        initConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperCellView.frame = wrapperCellView.frame.inset(by: UIEdgeInsets(top: 2, left: 1, bottom: 1, right: 1))
    }
    
    func setupUIElements() {
        // Wrapper View
        wrapperCellView = UIElementUtil.createAndAddTablesView(to: self)
        wrapperCellView.layer.borderWidth = 0
        wrapperCellView.layer.cornerRadius = 8
        
        // Store Name Label
        storeDisplayNameLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                                text: "Name",
                                                                fontSize: Constants.FONT_SMALL,
                                                                isCenterAligned: false,
                                                                isBold: true,
                                                                textColor: UIColor.black)
        // Store Created Label
        storeCreatedAtLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                              text: "Time",
                                                              fontSize: Constants.FONT_SMALL,
                                                              isCenterAligned: false,
                                                              isBold: false,
                                                              textColor: UIColor.black)
        
        // Store category Label
        storeCategoryLabel = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                             text: "Category",
                                                             fontSize: Constants.FONT_SMALL,
                                                             isCenterAligned: false,
                                                             isBold: true,
                                                             textColor: UIColor.black)
        imageReceipt = UIElementUtil.createAndAddImageView(to: wrapperCellView,
                                                           imageName: "storefront",
                                                           color: .link)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: Constants.VERTICAL_MARGIN_SMALL),
            imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            //MARK: it is better to set the height and width of an ImageView with constraints...
            imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
            storeDisplayNameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            storeDisplayNameLabel.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor, constant: 12),
            storeDisplayNameLabel.heightAnchor.constraint(equalToConstant: 20),
            storeDisplayNameLabel.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            storeCreatedAtLabel.topAnchor.constraint(equalTo: storeDisplayNameLabel.bottomAnchor, constant: 10),
            storeCreatedAtLabel.leadingAnchor.constraint(equalTo: storeDisplayNameLabel.leadingAnchor),
            storeCreatedAtLabel.heightAnchor.constraint(equalToConstant: 20),
            storeCreatedAtLabel.widthAnchor.constraint(lessThanOrEqualTo: storeDisplayNameLabel.widthAnchor),
            
            storeCategoryLabel.topAnchor.constraint(equalTo: storeCreatedAtLabel.bottomAnchor),
            storeCategoryLabel.leadingAnchor.constraint(equalTo: storeDisplayNameLabel.leadingAnchor),
            storeCategoryLabel.heightAnchor.constraint(equalToConstant: 20),
            storeCategoryLabel.widthAnchor.constraint(lessThanOrEqualTo: storeDisplayNameLabel.widthAnchor),
            
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 88)
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
    
    func configure(with model: Store) {
        storeDisplayNameLabel.text = model.displayName
        storeCreatedAtLabel.text = DateFormatter.formatDate(model.createdAt)
        storeCategoryLabel.text = model.category
        
        if !model.images.isEmpty {
            let firstImageUrl = model.images[0]
            if let url = URL(string: firstImageUrl) {
                imageReceipt.sd_setImage(with: url)
            } else {
                imageReceipt.image = UIImage(systemName: "storefront")
            }
        }
    }

}
