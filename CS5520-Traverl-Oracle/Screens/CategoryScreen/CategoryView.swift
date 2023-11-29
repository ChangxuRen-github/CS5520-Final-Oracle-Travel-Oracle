//
//  CategoryView.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class CategoryView: UIView {
    var contentWrapper: UIScrollView!
    var restaurantButton: UIButton!
    var coffeeShopButton: UIButton!
    var shoppingButton: UIButton!
    var barButton: UIButton!
    var hairSalonButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupContentWrapper()
        setupButtons()
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentWrapper)
    }
    
    func setupButtons(){
        restaurantButton = UIElementUtil.createAndAddCategotyImageButton(withImageName: "restaurantImage", title: "Restaurant")
        contentWrapper.addSubview(restaurantButton)
        
        coffeeShopButton = UIElementUtil.createAndAddCategotyImageButton(withImageName: "coffeeshopImage", title: "Coffee Shops")
        contentWrapper.addSubview(coffeeShopButton)
        
        shoppingButton = UIElementUtil.createAndAddCategotyImageButton(withImageName: "shoppingImage", title: "Shopping")
        contentWrapper.addSubview(shoppingButton)
        
        barButton = UIElementUtil.createAndAddCategotyImageButton(withImageName: "barImage", title: "Bars")
        contentWrapper.addSubview(barButton)
        
        hairSalonButton = UIElementUtil.createAndAddCategotyImageButton(withImageName: "hairsalonImage", title: "Hair Salons")
        contentWrapper.addSubview(hairSalonButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView Constraints
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            // Restaurant Button Constraints
            restaurantButton.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            restaurantButton.centerXAnchor.constraint(equalTo: contentWrapper.safeAreaLayoutGuide.centerXAnchor),

            // Coffee Shop Button Constraints
            coffeeShopButton.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            coffeeShopButton.centerXAnchor.constraint(equalTo: contentWrapper.safeAreaLayoutGuide.centerXAnchor),
            
            // Shopping Button Constraints
            shoppingButton.topAnchor.constraint(equalTo: coffeeShopButton.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            shoppingButton.centerXAnchor.constraint(equalTo: contentWrapper.safeAreaLayoutGuide.centerXAnchor),
           
            // Bar Button Constraints
            barButton.topAnchor.constraint(equalTo: shoppingButton.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            barButton.centerXAnchor.constraint(equalTo: contentWrapper.safeAreaLayoutGuide.centerXAnchor),

            // Hair Salon Button Constraints
            hairSalonButton.topAnchor.constraint(equalTo: barButton.bottomAnchor, constant: Constants.HORIZONTAL_MARGIN_SMALL),
            hairSalonButton.centerXAnchor.constraint(equalTo: contentWrapper.safeAreaLayoutGuide.centerXAnchor),
            hairSalonButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
