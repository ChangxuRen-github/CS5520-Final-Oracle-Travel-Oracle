//
//  CarouselCollectionViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit
import SDWebImage

class CarouselCollectionViewCell: UICollectionViewCell {
    static let IDENTIFIER =  "CarouselCollectionView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // configure the collection view cell with an image url
    func configure(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
}
