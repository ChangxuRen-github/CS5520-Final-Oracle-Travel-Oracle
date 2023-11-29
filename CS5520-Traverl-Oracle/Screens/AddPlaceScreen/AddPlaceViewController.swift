//
//  AddPlaceViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit

class AddPlaceViewController: UIViewController {
    
    var addPlaceView: AddPlaceView! {
        return view as? AddPlaceView
    }
    var selectedPrice: String = ""
    var selectedCategory: String = ""
    
    override func loadView() {
        view = AddPlaceView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Place"
        
        let addButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(onAddBarButtonTapped)
        )
        
        addButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = addButton
        
        addPlaceView.filterButton.addTarget(self, action: #selector(onButtonSubmitTapped), for: .touchUpInside)
        addPlaceView.pricePicker.delegate = self
        addPlaceView.pricePicker.dataSource = self
        addPlaceView.categoryPicker.delegate = self
        addPlaceView.categoryPicker.dataSource = self
        
    }
    
    @objc func onButtonSubmitTapped() {
        let filterPageViewController = FilterScreenController()
        navigationController?.pushViewController(filterPageViewController, animated: true)
    }
    
    @objc func onAddBarButtonTapped(){
        //        let newContactViewController = NewContactViewController()
        //        newContactViewController.delegate = self
        //        navigationController?.pushViewController(newContactViewController, animated: true)
        print("back the previous page")
    }
    
    @objc func addPlaceButtonTapped() {
        print("Add New Place button tapped")
    }
    

}


// MARK: - UIPickerViewDelegate
extension AddPlaceViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addPlaceView.pricePicker {
            return ["$", "$$", "$$$", "$$$$"][row]
        } else if pickerView == addPlaceView.categoryPicker {
            return ["Restaurant", "Coffee Shop", "Shopping"][row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == addPlaceView.pricePicker {
            selectedPrice = ["$", "$$", "$$$", "$$$$"][row]
            addPlaceView.priceTextField.text = selectedPrice // Update the text field
            addPlaceView.priceTextField.resignFirstResponder() // Dismiss the picker view
        } else if pickerView == addPlaceView.categoryPicker {
            selectedCategory = ["Restaurant", "Coffee Shop", "Shopping"][row]
            addPlaceView.categoryTextField.text = selectedCategory // Update the text field
            addPlaceView.categoryTextField.resignFirstResponder() // Dismiss the picker view
        }
    }
    
}

// MARK: - UIPickerViewDataSource
extension AddPlaceViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == addPlaceView.pricePicker {
            return 4 // $, $$, $$$, $$$$
        } else if pickerView == addPlaceView.categoryPicker {
            return 3 // Restaurant, Coffee Shop, Shopping
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}


