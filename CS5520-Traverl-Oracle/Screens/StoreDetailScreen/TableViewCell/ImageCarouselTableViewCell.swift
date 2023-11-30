//
//  ImageCarouselTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit

class ImageCarouselTableViewCell: UITableViewCell {
    static let IDENTIFIER: String = "ImageCarousel"
    let LAYOUT_ITEM_SIZE = 250
    
    // a list of image urls as the data source for collection view
    var imageURLs: [String] = []
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: Constants.VERTICAL_MARGIN_TINY,
                                           left: Constants.HORIZONTAL_MARGIN_TINY,
                                           bottom: Constants.VERTICAL_MARGIN_TINY,
                                           right: Constants.HORIZONTAL_MARGIN_TINY)
         

        
        // create a collection view with the flow layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false // Enable paging
        
        // Register the cell for the collection view
        collectionView.register(CarouselCollectionViewCell.self,
                                forCellWithReuseIdentifier: CarouselCollectionViewCell.IDENTIFIER)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add collection view as a subview of the table view cell
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    // configure the ImageCarouselTableViewCell with a list of image urls
    func configure(with imageURLs: [String]) {
        self.imageURLs = imageURLs
        collectionView.reloadData()
    }
}

// MARK: - Layout
extension ImageCarouselTableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

// MARK: - Collection view
extension ImageCarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: replace the real number of images
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.IDENTIFIER,
                                                      for: indexPath) as! CarouselCollectionViewCell
        cell.configure(with: imageURLs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LAYOUT_ITEM_SIZE, height: LAYOUT_ITEM_SIZE)
    }
}
