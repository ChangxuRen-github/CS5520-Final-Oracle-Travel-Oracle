//
//  SaveScreenTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 12/3/23.
//

import UIKit
import SDWebImage

class SavedStoreScreenTableViewCell: UITableViewCell {
    static let IDENTIFIER = "SavedStoreTableViewCell"
    var wrapperCellView: UIView!
    var profileImageView: UIImageView!
    var labelTitle: UILabel!
    var labelCategory: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupProfileImageView()
        setupLabelTitle()
        setupLabelDescription()
        initConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperCellView.frame = wrapperCellView.frame.inset(by: UIEdgeInsets(top: 2, left: 1, bottom: 1, right: 1))
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIElementUtil.createAndAddTablesView(to: self)
        wrapperCellView.layer.borderWidth = 0;
        wrapperCellView.layer.cornerRadius = 8
    }
    
    func setupLabelTitle() {
        labelTitle = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                     text: "Name",
                                                     fontSize: Constants.FONT_SMALL,
                                                     isCenterAligned: false,
                                                     isBold: true,
                                                     textColor: UIColor.black)
    }
    
    func setupLabelDescription() {
        labelCategory = UIElementUtil.createAndAddLabel(to: wrapperCellView,
                                                        text: "Category",
                                                        fontSize: Constants.FONT_SMALL,
                                                        isCenterAligned: false,
                                                        isBold: true,
                                                        textColor: UIColor.black)
    }
    
    func setupProfileImageView() {
        profileImageView = UIElementUtil.createAndAddImageView(to: wrapperCellView, imageName:"storefront", color: .link)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            profileImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: Constants.VERTICAL_MARGIN_SMALL),
            profileImageView.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),

            labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelTitle.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            labelTitle.heightAnchor.constraint(equalToConstant: 20),
            labelTitle.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),

            labelCategory.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelCategory.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            labelCategory.heightAnchor.constraint(equalToConstant: 20),
            labelCategory.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),

            wrapperCellView.heightAnchor.constraint(equalToConstant: 88)
        ])
    }

    
    //MARK: unused methods...
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
        labelTitle.text = model.displayName
        labelCategory.text = model.category
        let imageUrlString = model.images[0]
        if let imageUrl = URL(string: imageUrlString) {
            profileImageView.sd_setImage(with: imageUrl)
        }
    }
}

