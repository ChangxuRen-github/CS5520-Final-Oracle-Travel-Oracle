//
//  AddPlaceViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit
import PhotosUI


class AddPlaceViewController: UIViewController, FilterScreenDelegate, LocationScreenDelegate {

    var addPlaceView: AddPlaceView! {
        return view as? AddPlaceView
    }
    var user: User
    var selectedPrice: String = ""
    var selectedCategory: String = ""
    var selectedLocation: String = ""
    var selectedTag = Tag(goodForBreakfast: "N/A", goodForLunch: "N/A", goodForDinner: "N/A", takesReservations: "N/A", vegetarianFriendly: "N/A", cuisine: "N/A", liveMusic: "N/A", outdoorSeating: "N/A", freeWIFI: "N/A")
    var currentCameraButton: UIButton?
    var imageUrls: [String] = []
    let childProgressView = ProgressSpinnerViewController()
    let filterPageViewController = FilterScreenController()
    
    init(with user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addPlaceView.addNewPlaceButton.addTarget(self,
                                               action: #selector(addPlaceButtonTapped),
                                               for: .touchUpInside)
        addPlaceView.pricePicker.delegate = self
        addPlaceView.pricePicker.dataSource = self
        addPlaceView.categoryPicker.delegate = self
        addPlaceView.categoryPicker.dataSource = self
        
    }
    
    @objc func onLocationButtonSubmitTapped() {
        let locationViewController = LocationScreenViewController()
        locationViewController.delegate = self
        navigationController?.pushViewController(locationViewController, animated: true)
    }

    
    @objc func selectPhoto(sender: UIButton) {
        if let currentIndex = addPlaceView.cameraButtons.firstIndex(of: sender) {
            if currentIndex == 0 || (currentIndex - 1 < addPlaceView.imageViews.count && addPlaceView.imageViews[currentIndex-1].image != nil) {
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 1
                configuration.filter = .images

                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                present(picker, animated: true)
                currentCameraButton = sender
            } else {
                let alertController = UIAlertController(title: "Upload Error", message: "Please upload pictures first.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func onFilterButtonSubmitTapped() {
        filterPageViewController.delegate = self
        navigationController?.pushViewController(filterPageViewController, animated: true)
    }
    
    @objc func onCancelBarButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func filterScreen(_ filterScreen: FilterScreenController, didSelectTag tag: Tag) {
        self.selectedTag = tag
    }
    
    func locationScreen(_ locationScreen: LocationScreenViewController, didSelectLocation location: String) {
        self.selectedLocation = location
    }
    
}

// MARK: - UIPickerViewDelegate
extension AddPlaceViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addPlaceView.pricePicker {
            return ["$", "$$", "$$$", "$$$$"][row]
        } else if pickerView == addPlaceView.categoryPicker {
            return [Constants.STORE_CATEGORY_RESTAURANT, Constants.STORE_CATEGORY_COFEE_SHOP, Constants.STORE_CATEGORY_SHOPPING, Constants.STORE_CATEGORY_BAR, Constants.STORE_CATEGORY_HAIR_SALON][row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == addPlaceView.pricePicker {
            selectedPrice = ["$", "$$", "$$$", "$$$$"][row]
            addPlaceView.priceTextField.text = selectedPrice
            addPlaceView.priceTextField.resignFirstResponder()
        } else if pickerView == addPlaceView.categoryPicker {
            selectedCategory = [Constants.STORE_CATEGORY_RESTAURANT, Constants.STORE_CATEGORY_COFEE_SHOP, Constants.STORE_CATEGORY_SHOPPING, Constants.STORE_CATEGORY_BAR, Constants.STORE_CATEGORY_HAIR_SALON][row]
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

        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image as? UIImage, let button = self?.currentCameraButton {
                    self?.setImage(image, forButton: button)
                    
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    self?.addPlaceView.imageViews.append(imageView)
                }
            }
        }

        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { [weak self] url, error in
            DispatchQueue.main.async {
                if let imageURL = url {

                    let imageURLString = imageURL.absoluteString
                    print("Selected Image URL: \(imageURL)")
                    self?.imageUrls.append(imageURLString)
                    

                }
            }
        }
    }

    
    func setImage(_ image: UIImage, forButton button: UIButton) {
        button.setBackgroundImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.setImage(nil, for: .normal)
    }
}

// - Action listener
extension AddPlaceViewController {

    @objc func addPlaceButtonTapped() {
        if let title = addPlaceView.titleTextField.text, !title.isEmpty,
           let description = addPlaceView.descriptionTextField.text, !description.isEmpty, !imageUrls.isEmpty{
            let store = Store(
                id: UUID().uuidString,
                createdAt: Date(),
                createdBy: user.uid,
                displayName: title,
                description: description,
                price: selectedPrice,
                category: selectedCategory,
                images: imageUrls,
                tag: Tag(
                    goodForBreakfast: selectedTag.goodForBreakfast,
                    goodForLunch: selectedTag.goodForLunch,
                    goodForDinner: selectedTag.goodForDinner,
                    takesReservations: selectedTag.takesReservations,
                    vegetarianFriendly: selectedTag.vegetarianFriendly,
                    cuisine: selectedTag.cuisine,
                    liveMusic: selectedTag.liveMusic,
                    outdoorSeating: selectedTag.outdoorSeating,
                    freeWIFI: selectedTag.freeWIFI
                ),
                location: selectedLocation
            )
            var imageArray: [UIImage] = []
            for imageView in addPlaceView.imageViews {
                if let image = imageView.image {
                    imageArray.append(image)
                }
            }
            
            
            self.showActivityIndicator()
            DBManager.dbManager.addStore(with: store, with: imageArray) { result in
                self.hideActivityIndicator()
                switch result {
                case .success(let store):
                    self.navigationController?.popViewController(animated: true)
                    print("Store added successfully: \(store)")
                    
                case .failure(let error):
                    print("Error adding store: \(error)")
                }
            }
            
        } else {

            if addPlaceView.titleTextField.text?.isEmpty ?? true {
                AlertUtil.showErrorAlert(viewController: self, title: "Error", errorMessage: "Please enter a title.")
            } else if addPlaceView.descriptionTextField.text?.isEmpty ?? true {
                AlertUtil.showErrorAlert(viewController: self, title: "Error", errorMessage: "Please enter a description.")
            } else if imageUrls.isEmpty {
                AlertUtil.showErrorAlert(viewController: self, title: "Error", errorMessage: "Please upload at least one picture.")
            }
        }

    }
    
}

// - Spinner
extension AddPlaceViewController: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}


