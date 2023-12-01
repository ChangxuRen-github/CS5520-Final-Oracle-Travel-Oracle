//
//  LocationScreenView.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/30/23.
//

import UIKit

class LocationScreenView: UIView {

    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipCodeTextField: UITextField!
    var saveAddressButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupAddressTextField()
        setupCityStateTextField()
        setupZipCodeTextField()
        setupSaveAddressButton()
        initConstraints()
        
    }
    
    
    func setupAddressTextField() {
        addressTextField = UITextField()
        addressTextField.placeholder = "Address"
        addressTextField.borderStyle = .roundedRect
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressTextField)
    }
    
    func setupCityStateTextField() {
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.borderStyle = .roundedRect
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateTextField)
    }
    
    func setupZipCodeTextField() {
        zipCodeTextField = UITextField()
        zipCodeTextField.placeholder = "Zip Code"
        zipCodeTextField.borderStyle = .roundedRect
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeTextField)
    }
    
    func setupSaveAddressButton() {
        saveAddressButton = UIButton()
        saveAddressButton.setTitle("Save Address", for: .normal)
        saveAddressButton.backgroundColor = UIColor(hexString: "#c1372d")
        saveAddressButton.layer.cornerRadius = 5
        saveAddressButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveAddressButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {

        NSLayoutConstraint.activate([

            addressTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addressTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),

            cityStateTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cityStateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),

            zipCodeTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            zipCodeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            zipCodeTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 20),

            saveAddressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveAddressButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveAddressButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            saveAddressButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    


}
