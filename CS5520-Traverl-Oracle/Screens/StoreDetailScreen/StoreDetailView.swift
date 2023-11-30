//
//  StoreDetailView.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/28/23.
//

import UIKit

class StoreDetailView: UIView {
    // contains sections that displays carousel, store description, and reivews
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupTableView()
        initConstraints()
    }
    
    func setupTableView() {
        tableView = UIElementUtil.createAndAddTablesView(to: self)
        // TODO: we need to register all the table view cells here...
        tableView.register(ImageCarouselTableViewCell.self, forCellReuseIdentifier: ImageCarouselTableViewCell.IDENTIFIER)
        tableView.register(StoreDescriptionTableViewCell.self, forCellReuseIdentifier: StoreDescriptionTableViewCell.IDENTIFIER)
        tableView.register(ReviewsTableViewCell.self, forCellReuseIdentifier: ReviewsTableViewCell.IDENTIFIER)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.VERTICAL_MARGIN_TINY),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.VERTICAL_MARGIN_TINY),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
