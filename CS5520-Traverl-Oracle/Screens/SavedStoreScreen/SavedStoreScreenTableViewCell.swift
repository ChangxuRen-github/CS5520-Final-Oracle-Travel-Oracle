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

    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profileImageView)
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTitle)
    }
    
    func setupLabelDescription() {
        labelCategory = UILabel()
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCategory)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            profileImageView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelTitle.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            labelTitle.heightAnchor.constraint(equalToConstant: 20),

            labelCategory.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelCategory.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            labelCategory.heightAnchor.constraint(equalToConstant: 20),

            wrapperCellView.heightAnchor.constraint(equalToConstant: 90)
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

