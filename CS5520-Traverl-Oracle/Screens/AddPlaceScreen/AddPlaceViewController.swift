//
//  AddPlaceViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit
import PhotosUI

class AddPlaceViewController: UIViewController {
    
    var addPlaceView: AddPlaceView! {
        return view as? AddPlaceView
    }
    var selectedPrice: String = ""
    var selectedCategory: String = ""
    var currentCameraButton: UIButton?
    
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
            action: #selector(onCancelBarButtonTapped)
        )
        
        addButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = addButton
        
        addPlaceView.filterButton.addTarget(self, action: #selector(onFilterButtonSubmitTapped), for: .touchUpInside)
        addPlaceView.locationButton.addTarget(self, action:#selector(onLocationButtonSubmitTapped), for: .touchUpInside)
        for button in addPlaceView.cameraButtons {
            button.addTarget(self, action: #selector(selectPhoto(sender:)), for: .touchUpInside)
            print("Target action set for button")
        }
        addPlaceView.pricePicker.delegate = self
        addPlaceView.pricePicker.dataSource = self
        addPlaceView.categoryPicker.delegate = self
        addPlaceView.categoryPicker.dataSource = self
        
    }
    
    @objc func onLocationButtonSubmitTapped() {
        let locationViewController = LocationScreenViewController()
        navigationController?.pushViewController(locationViewController, animated: true)
    }
    
    @objc func selectPhoto(sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        currentCameraButton = sender
    }

    func setImage(_ image: UIImage, forButton button: UIButton) {
        button.setBackgroundImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.setImage(nil, for: .normal)
    }
    
    @objc func onFilterButtonSubmitTapped() {
        let filterPageViewController = FilterScreenController()
        navigationController?.pushViewController(filterPageViewController, animated: true)
    }
    
    @objc func onCancelBarButtonTapped(){
        print("back the previous page")
    }
    
    @objc func addPlaceButtonTapped() {
        print("Test Save Store Button Tapped.")

    }
}



// MARK: - UIPickerViewDelegate
extension AddPlaceViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addPlaceView.pricePicker {
            return ["$", "$$", "$$$", "$$$$"][row]
        } else if pickerView == addPlaceView.categoryPicker {
            return ["Restaurant", "Coffee Shops", "Shopping", "Bars", "Hair Salons"][row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == addPlaceView.pricePicker {
            selectedPrice = ["$", "$$", "$$$", "$$$$"][row]
            addPlaceView.priceTextField.text = selectedPrice
            addPlaceView.priceTextField.resignFirstResponder()
        } else if pickerView == addPlaceView.categoryPicker {
            selectedCategory = ["Restaurant", "Coffee Shops", "Shopping", "Bars", "Hair Salons"][row]
            addPlaceView.categoryTextField.text = selectedCategory
            addPlaceView.categoryTextField.resignFirstResponder()
        }
    }
    
}

// MARK: - UIPickerViewDataSource
extension AddPlaceViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == addPlaceView.pricePicker {
            return 4
        } else if pickerView == addPlaceView.categoryPicker {
            return 5
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension AddPlaceViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else { return }

        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image as? UIImage, let button = self?.currentCameraButton {
                    self?.setImage(image, forButton: button)
                }
            }
        }
    }
}



