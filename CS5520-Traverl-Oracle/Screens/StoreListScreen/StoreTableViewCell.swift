//
//  StoreTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var storeDisplayNameLabel: UILabel!
    var storeCreatedAtLabel: UILabel!
    var storeLocationLabel: UILabel!
    var imageReceipt: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        setupimageReceipt()
        initConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperCellView.frame = wrapperCellView.frame.inset(by: UIEdgeInsets(top: 2, left: 1, bottom: 1, right: 1))
    }
    
    func setupLabels() {
        // Wrapper View
        wrapperCellView = UIView()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 0
        wrapperCellView.layer.cornerRadius = 0
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperCellView)
    
        
        // Store Name Label
        storeDisplayNameLabel = UIElementUtil.createAndAddLabel(to: self, text: "Name", fontSize: Constants.FONT_SMALL, isCenterAligned: false, isBold: true, textColor: .black)
        wrapperCellView.addSubview(storeDisplayNameLabel)
        
        // Store Created Label
        storeCreatedAtLabel = UIElementUtil.createAndAddLabel(to: self, text: "Time", fontSize: 12, isCenterAligned: false, isBold: false, textColor: .black)
        wrapperCellView.addSubview(storeCreatedAtLabel)
        
        // Store Location Label
        storeLocationLabel = UIElementUtil.createAndAddLabel(to: self, text: "Location", fontSize: 12, isCenterAligned: false, isBold: true, textColor: .black)
        wrapperCellView.addSubview(storeLocationLabel)
    }
    
    func setupimageReceipt(){
        imageReceipt = UIImageView()
        imageReceipt.image = UIImage(systemName: "storefront")
        imageReceipt.contentMode = .scaleToFill
        imageReceipt.tintColor = .black
        imageReceipt.clipsToBounds = true
        imageReceipt.layer.cornerRadius = 10
        imageReceipt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageReceipt)
        }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            storeDisplayNameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            storeDisplayNameLabel.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor, constant: 12),
            storeDisplayNameLabel.heightAnchor.constraint(equalToConstant: 20),
            storeDisplayNameLabel.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            storeCreatedAtLabel.topAnchor.constraint(equalTo: storeDisplayNameLabel.bottomAnchor, constant: 10),
            storeCreatedAtLabel.leadingAnchor.constraint(equalTo: storeDisplayNameLabel.leadingAnchor),
            storeCreatedAtLabel.heightAnchor.constraint(equalToConstant: 20),
            storeCreatedAtLabel.widthAnchor.constraint(lessThanOrEqualTo: storeDisplayNameLabel.widthAnchor),
            
            storeLocationLabel.topAnchor.constraint(equalTo: storeCreatedAtLabel.bottomAnchor),
            storeLocationLabel.leadingAnchor.constraint(equalTo: storeDisplayNameLabel.leadingAnchor),
            storeLocationLabel.heightAnchor.constraint(equalToConstant: 20),
            storeLocationLabel.widthAnchor.constraint(lessThanOrEqualTo: storeDisplayNameLabel.widthAnchor),
            
            imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: Constants.VERTICAL_MARGIN_SMALL),
            imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            //MARK: it is better to set the height and width of an ImageView with constraints...
            imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
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
}

