//
//  FilterScreenView.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit

class FilterScreenView: UIView {
    
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}





