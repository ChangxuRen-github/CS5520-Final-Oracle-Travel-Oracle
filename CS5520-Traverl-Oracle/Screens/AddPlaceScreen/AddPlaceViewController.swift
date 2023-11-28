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
        // Logic to handle when the 'Add New Place' button is tapped
        print("Add New Place button tapped")
    }
}

// MARK: - UIPickerViewDelegate
extension AddPlaceViewController: UIPickerViewDelegate {
    // Implement picker view delegate methods
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle picker selection
    }
}

// MARK: - UIPickerViewDataSource
extension AddPlaceViewController: UIPickerViewDataSource {
    // Implement picker view data source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return the number of rows for each picker
        return 10 // Placeholder value
    }
}

