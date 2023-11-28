//
//  FilterScreenTableViewCell.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//


import UIKit

class FilterScreenCell: UITableViewCell {
    static let identifier = "FilterScreenCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Additional label styling
        return label
    }()
    
    let picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        // Additional picker styling
        return pickerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(picker)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            picker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            picker.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}




