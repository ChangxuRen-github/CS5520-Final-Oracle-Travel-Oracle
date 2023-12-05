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
    var scrollView: UIScrollView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
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
        scrollView.addSubview(addressTextField)
    }
    
    func setupCityStateTextField() {
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.borderStyle = .roundedRect
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cityStateTextField)
    }
    
    func setupZipCodeTextField() {
        zipCodeTextField = UITextField()
        zipCodeTextField.placeholder = "Zip Code"
        zipCodeTextField.borderStyle = .roundedRect
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(zipCodeTextField)
    }
    
    func setupSaveAddressButton() {
        saveAddressButton = UIButton()
        saveAddressButton.setTitle("Save Address", for: .normal)
        saveAddressButton.backgroundColor = UIColor(hexString: "#c1372d")
        saveAddressButton.layer.cornerRadius = 5
        saveAddressButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(saveAddressButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for scrollView
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            // Constraints for addressTextField
            addressTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            addressTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40), // Optional: Match width of scrollView

            // Constraints for cityStateTextField
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            cityStateTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cityStateTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            cityStateTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40), // Optional: Match width of scrollView

            // Constraints for zipCodeTextField
            zipCodeTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 20),
            zipCodeTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            zipCodeTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            zipCodeTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40), // Optional: Match width of scrollView

            // Constraints for saveAddressButton
            saveAddressButton.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 20),
            saveAddressButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            saveAddressButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            saveAddressButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20), // Important for scrollable content size
            saveAddressButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    
}
