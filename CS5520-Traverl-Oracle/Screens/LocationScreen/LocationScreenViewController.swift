//
//  LocationScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/30/23.
//

import UIKit

class LocationScreenViewController: UIViewController {
    
    let locationScreen = LocationScreenView()
    
    public struct Package {
        var address: String?
        var cityState: String?
        var zipCode: String?
        
        init(address: String? = nil, cityState: String? = nil, zipCode: String? = nil) {
            self.address = address
            self.cityState = cityState
            self.zipCode = zipCode
        }
    }
    
    override func loadView() {
        view = locationScreen
        title = "Add Address"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationScreen.saveAddressButton.addTarget(self, action: #selector(onShowProfileButtonTapped), for: .touchUpInside)
        
    }
    
    func validateZipCode(_ zipCode: String?) -> Bool {
        let zipCodePattern = #"^\d{5}$"#
        if let zipCode = zipCode, zipCode.range(of: zipCodePattern, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    @objc func onShowProfileButtonTapped() {
        
        let address = locationScreen.addressTextField.text
        let cityState = locationScreen.cityStateTextField.text
        let zipCode = locationScreen.zipCodeTextField.text
        
        if let unwrappedAddress = address, let unwrappedCityState = cityState, let unwrappedZipCode = zipCode {
            
            if unwrappedAddress.isEmpty || unwrappedZipCode.isEmpty || unwrappedCityState.isEmpty {
                    let alertController = UIAlertController(title: "Error", message: "Please fill in all required fields", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                
            } else if validateZipCode(zipCode){
                
                let package = Package(address: unwrappedAddress, cityState: unwrappedCityState, zipCode: unwrappedZipCode)
                
               navigationController?.popViewController(animated: true)
                
            } else if !validateZipCode(zipCode) {
                
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid 5-digit zip code", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
