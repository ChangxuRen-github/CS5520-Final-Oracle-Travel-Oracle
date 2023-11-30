//
//  StoreListView.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class StoreListView: UIView {
    
    var storeTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStoreTableView()
        initConstraints()
    }
    
    func setupStoreTableView() {
        storeTableView = UITableView()
        storeTableView.register(StoreTableViewCell.self, forCellReuseIdentifier: "stores")
        storeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(storeTableView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            storeTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            storeTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            storeTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            storeTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
