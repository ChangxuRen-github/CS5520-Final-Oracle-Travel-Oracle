//
//  ProgressSpinnerViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/18/23.
//

import UIKit

class ProgressSpinnerViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
