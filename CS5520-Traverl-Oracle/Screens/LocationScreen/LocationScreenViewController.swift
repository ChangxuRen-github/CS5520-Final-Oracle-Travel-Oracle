//
//  LocationScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/30/23.
//

import UIKit

protocol LocationScreenDelegate: AnyObject {
    func locationScreen(_ locationScreen: LocationScreenViewController, didSelectLocation location: String)
    func locationScreen(_ locationScreen: LocationScreenViewController, didInputLocationData data: LocationData)
}


class LocationScreenViewController: UIViewController {
    
    let locationScreen = LocationScreenView()
    var location = ""
    var delegate: LocationScreenDelegate?
    var initialLocationData: LocationData?

    override func loadView() {
        view = locationScreen
        title = "Add Address"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let initialData = initialLocationData {
            locationScreen.addressTextField.text = initialData.address
            locationScreen.cityStateTextField.text = initialData.cityState
            locationScreen.zipCodeTextField.text = initialData.zipCode
        }
        locationScreen.saveAddressButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#b34538")
    }
    
    func validateZipCode(_ zipCode: String?) -> Bool {
        let zipCodePattern = #"^\d{5}$"#
        if let zipCode = zipCode, zipCode.range(of: zipCodePattern, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let address = locationScreen.addressTextField.text ?? ""
        let cityState = locationScreen.cityStateTextField.text ?? ""
        let zipCode = locationScreen.zipCodeTextField.text ?? ""
        let data = LocationData(address: address, cityState: cityState, zipCode: zipCode)
        delegate?.locationScreen(self, didInputLocationData: data)
    }


    
    @objc func onSaveButtonTapped() {
        
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
                
                if let unwrappedAddress = address,
                   let unwrappedCityState = cityState,
                   let unwrappedZipCode = zipCode {
                    
                    let locationString = "\(unwrappedAddress), \(unwrappedCityState), \(unwrappedZipCode)"
                    delegate?.locationScreen(self, didSelectLocation: locationString)
                    navigationController?.popViewController(animated: true)
                }

                
            } else if !validateZipCode(zipCode) {
                
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid 5-digit zip code", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
