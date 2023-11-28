//
//  FilterScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit

class FilterScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var tableView: UITableView!
    
    // Define a struct that represents a section in the table view
    struct FilterSection {
        let headerTitle: String
        let pickerData: [String]
    }
    
    // Define your sections and corresponding picker data
    var filterSections: [FilterSection] = [
        FilterSection(headerTitle: "Price", pickerData: ["All", "$", "$$", "$$$", "$$$$"]),
        FilterSection(headerTitle: "Good for Breakfast", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Good for Lunch", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Good for Dinner", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Takes Reservations", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Vegetarian Friendly", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Cuisine", pickerData: ["All", "Italian", "Chinese", "American", "Other"]),
        FilterSection(headerTitle: "Live Music", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Outdoor Seating", pickerData: ["All", "Yes", "No"]),
        FilterSection(headerTitle: "Free Wi-Fi", pickerData: ["All", "Yes", "No"])
    ]
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterScreenCell.self, forCellReuseIdentifier: FilterScreenCell.identifier)
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        title = "Filters"
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(onDoneButtonTapped)
        )
        
        doneButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func onDoneButtonTapped() {
        print("save data")
    }
    
    // UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // One picker per section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterScreenCell.identifier, for: indexPath) as! FilterScreenCell
        let filterSection = filterSections[indexPath.section]
        
        cell.configure(with: filterSection.headerTitle)
        cell.picker.tag = indexPath.section
        cell.picker.dataSource = self
        cell.picker.delegate = self
        
        // Default to the first option ("All")
        cell.picker.selectRow(0, inComponent: 0, animated: false)
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section].headerTitle
    }
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterSections[pickerView.tag].pickerData.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterSections[pickerView.tag].pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Here you can handle the selection of a specific option in the picker
        let option = filterSections[pickerView.tag].pickerData[row]
        print("Selected \(option) for \(filterSections[pickerView.tag].headerTitle)")
    }
}


