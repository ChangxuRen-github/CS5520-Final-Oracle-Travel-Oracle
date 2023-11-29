//
//  FilterScreenTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//


import UIKit

class FilterScreenCell: UITableViewCell {
    static let identifier = "FilterScreenCell"

    let label = UILabel()
    let optionsButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupOptionsButton()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

    }
    
    private func setupOptionsButton() {
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionsButton)
        optionsButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            optionsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(with title: String, selectedOption: String) {
        label.text = title
        optionsButton.setTitle(selectedOption, for: .normal)
        optionsButton.setTitleColor(selectedOption == "All" ? .black : .systemBlue, for: .normal)
    }
}






