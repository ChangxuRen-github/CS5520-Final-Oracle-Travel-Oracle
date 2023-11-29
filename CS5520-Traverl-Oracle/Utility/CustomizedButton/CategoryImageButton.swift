//
//  CategoryImageButton.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class CategoryImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Ensure the button image and title are aligned properly
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set imageView to fill the entire button
            imageView?.frame = self.bounds
            imageView?.contentMode = .scaleAspectFill
            imageView?.clipsToBounds = true // Ensure the image is clipped to the bounds
        
        // Ensure imageView and titleLabel are in the button bounds
        imageView?.frame = self.bounds
        titleLabel?.frame = self.bounds
        
        // Bring the titleLabel to the front and center it over the imageView
        if let titleLabel = self.titleLabel, let imageSize = self.imageView?.image?.size {
            bringSubviewToFront(titleLabel)
            titleLabel.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
            titleLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.titleLabel?.textAlignment = .center
    }
}
