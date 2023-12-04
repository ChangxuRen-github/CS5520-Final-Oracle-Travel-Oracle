//
//  AddPlaceView.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit


class AddPlaceView: UIView {

    var titleLabel = UILabel()
    var titleTextField = UITextField()
    var descriptionLabel = UILabel()
    var descriptionTextField = UITextField()
    var grayRectangle1 = UIView()
    var grayRectangle2 = UIView()
    var priceLabel = UILabel()
    var pricePicker = UIPickerView()
    var priceTextField = UITextField()
    var categoryLabel = UILabel()
    var categoryPicker = UIPickerView()
    var categoryTextField = UITextField()
    var filterLabel = UILabel()
    var filterButton = UIButton()
    var locationLabel = UILabel()
    var locationButton = UIButton()
    var addPhotoLabel = UILabel()
    var cameraButtons: [UIButton] = []
    var imageViews: [UIImageView] = []
    var imageURLs: [String] = []
    var selectedPrice: String?
    var selectedCategory: String?
    var addNewPlaceButton = UIButton()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTitleLable()
        setupTitleTextField()
        setupDescriptionLabel()
        setupDescriptionTextField()
        setupGap1()
        setupGap2()
        setupPriceRow()
        setupCategoryRow()
        setupFilterRow()
        setupLocationRow()
        setupAddNewPlaceButton()
        setupAddPhotoLable()
        setupAddPhotoRow()
//        setupCameraButton()
        initConstraints()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupTitleLable() {
        titleLabel.text = "Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelContainer = UIView()
        titleLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        titleLabelContainer.layer.borderColor = UIColor.lightGray.cgColor
        titleLabelContainer.layer.borderWidth = 1.0
        titleLabelContainer.addSubview(titleLabel)
        self.addSubview(titleLabelContainer)

        NSLayoutConstraint.activate([
            titleLabelContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            titleLabelContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            titleLabelContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            titleLabelContainer.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.centerYAnchor.constraint(equalTo: titleLabelContainer.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleLabelContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabelContainer.trailingAnchor, constant: -10)
        ])
    }
    
    func setupTitleTextField() {
        titleTextField.placeholder = "Start typing..."
        titleTextField.layer.borderColor = UIColor.clear.cgColor
        titleTextField.layer.borderWidth = 0
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleTextField)


        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.addSubview(bottomBorder)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            titleTextField.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            bottomBorder.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    
    func setupDescriptionLabel() {
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: descriptionLabel.font.pointSize)
        descriptionLabel.textAlignment = .left
        descriptionLabel.backgroundColor = .white
        descriptionLabel.layer.borderColor = UIColor.lightGray.cgColor
        descriptionLabel.clipsToBounds = true
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabelContainer = UIView()
        descriptionLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelContainer.layer.borderColor = UIColor.lightGray.cgColor
        descriptionLabelContainer.layer.borderWidth = 1.0
        descriptionLabelContainer.addSubview(descriptionLabel)
        self.addSubview(descriptionLabelContainer)

        NSLayoutConstraint.activate([
            descriptionLabelContainer.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 35),
            descriptionLabelContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            descriptionLabelContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            descriptionLabelContainer.heightAnchor.constraint(equalToConstant: 50),

            descriptionLabel.centerYAnchor.constraint(equalTo: descriptionLabelContainer.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabelContainer.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionLabelContainer.trailingAnchor, constant: -10)
        ])
    }

    
    func setupDescriptionTextField() {
        descriptionTextField.placeholder = "Start typing..."
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionTextField)

        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.addSubview(bottomBorder)

        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0),
            descriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            bottomBorder.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: descriptionTextField.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    
    func setupGap1() {
        grayRectangle1 = UIView()
        grayRectangle1.backgroundColor = UIColor(hexString: "#f3f4f3")
        grayRectangle1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(grayRectangle1)
        
        NSLayoutConstraint.activate([
            grayRectangle1.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            grayRectangle1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            grayRectangle1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            grayRectangle1.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupGap2() {
        grayRectangle2 = UIView()
        grayRectangle2.backgroundColor = UIColor(hexString: "#f3f4f3")
        grayRectangle2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(grayRectangle2)
        
        NSLayoutConstraint.activate([
            grayRectangle2.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            grayRectangle2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            grayRectangle2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            grayRectangle2.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupPriceRow() {
        priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.font = UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)

        pricePicker = UIPickerView()

        priceTextField = UITextField()
        priceTextField.isUserInteractionEnabled = false
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let attributedPlaceholder = NSAttributedString(string: "Select...", attributes: placeholderAttributes)

        priceTextField = UITextField()
        priceTextField.attributedText = attributedPlaceholder
        priceTextField.inputView = pricePicker
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceTextField)
        
        priceTextField.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: grayRectangle2.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            priceTextField.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            priceTextField.topAnchor.constraint(equalTo: grayRectangle2.bottomAnchor, constant: 15),
            priceTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    func setupCategoryRow() {
        categoryLabel = UILabel()
        categoryLabel.text = "Category"
        categoryLabel.font = UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)

        categoryPicker = UIPickerView()

        categoryTextField = UITextField()
        categoryTextField.isUserInteractionEnabled = false
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let attributedPlaceholder = NSAttributedString(string: "Select...", attributes: placeholderAttributes)
        categoryTextField.attributedText = attributedPlaceholder
        categoryTextField.inputView = categoryPicker
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryTextField)
        
        categoryTextField.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            categoryTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
            categoryTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    func setupFilterRow() {
        filterLabel = UILabel()
        filterLabel.text = "Filters"
        filterLabel.font = UIFont.boldSystemFont(ofSize: filterLabel.font.pointSize)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterLabel)

        filterButton = UIButton()
        filterButton.setTitle("Select...", for: .normal)
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        filterButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterButton)
        

        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 25),
            filterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 25),
            filterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }

    
    func setupLocationRow() {
        locationLabel = UILabel()
        locationLabel.text = "Location"
        locationLabel.font = UIFont.boldSystemFont(ofSize: locationLabel.font.pointSize)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationLabel)


        locationButton = UIButton()
        locationButton.setTitle("Select...", for: .normal)
        locationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        locationButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationButton)
        

        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 25),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 25),
            locationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    func setupAddNewPlaceButton() {
        addNewPlaceButton = UIButton()
        addNewPlaceButton.setTitle("Add New Place", for: .normal)
        addNewPlaceButton.backgroundColor = UIColor(hexString: "#c1372d")
        addNewPlaceButton.layer.cornerRadius = 5
        addNewPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addNewPlaceButton)
    }
    
    
    func setupAddPhotoLable() {
        addPhotoLabel = UILabel()
        addPhotoLabel.text = "Add Photos"
        addPhotoLabel.font = UIFont.boldSystemFont(ofSize: 32)
        addPhotoLabel.textColor = UIColor.darkGray
        addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addPhotoLabel)
        
        NSLayoutConstraint.activate([
            addPhotoLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            addPhotoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
        ])
    }
    
    func setupAddPhotoRow() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        for _ in 0..<4 {
            let cameraButton = UIButton(type: .system)
            setupCameraButton(cameraButton)
            cameraButtons.append(cameraButton)
            stackView.addArrangedSubview(cameraButton)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: addPhotoLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func setupCameraButton(_ button: UIButton) {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "plus.viewfinder"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(hexString: "#c1372d")

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 80)
        ])
    }


    func initConstraints() {
        NSLayoutConstraint.activate([
            addNewPlaceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addNewPlaceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addNewPlaceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addNewPlaceButton.heightAnchor.constraint(equalToConstant: 44),
        
        ])
        
    }

}



