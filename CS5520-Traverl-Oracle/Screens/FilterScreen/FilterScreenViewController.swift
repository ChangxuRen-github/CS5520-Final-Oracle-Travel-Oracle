//
//  FilterScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit

protocol FilterScreenDelegate: AnyObject {
    func filterScreen(_ filterScreen: FilterScreenController, didSelectTag tag: Tag)
}

class FilterScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var delegate: FilterScreenDelegate?
    
    var tag: Tag = Tag(goodForBreakfast: "N/A", goodForLunch: "N/A", goodForDinner: "N/A", takesReservations: "N/A", vegetarianFriendly: "N/A", cuisine: "N/A", liveMusic: "N/A", outdoorSeating: "N/A", freeWIFI: "N/A")
    
    let filterTitles: [String] = [
        "Good for Breakfast", "Good for Lunch", "Good for Dinner",
        "Takes Reservations", "Vegetarian Friendly", "Cuisine",
        "Live Music", "Outdoor Seating", "Free Wi-Fi"
    ]
    
    let filterOptions: [String: [String]] = [
        "Good for Breakfast": ["N/A", "Yes", "No"],
        "Good for Lunch": ["N/A", "Yes", "No"],
        "Good for Dinner": ["N/A", "Yes", "No"],
        "Takes Reservations": ["N/A", "Yes", "No"],
        "Vegetarian Friendly": ["N/A", "Yes", "No"],
        "Cuisine": ["N/A", "Italian", "Chinese", "American", "Other"],
        "Live Music": ["N/A", "Yes", "No"],
        "Outdoor Seating": ["N/A", "Yes", "No"],
        "Free Wi-Fi": ["N/A", "Yes", "No"]
    ]

    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterScreenCell.self, forCellReuseIdentifier: FilterScreenCell.identifier)
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hexString: "#c1372d")
    }
    
    @objc private func doneTapped() {
        delegate?.filterScreen(self, didSelectTag: tag)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalCellHeight = tableView.frame.height
        let numberOfCells = CGFloat(filterTitles.count)
        return totalCellHeight / numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterScreenCell.identifier, for: indexPath) as? FilterScreenCell else {
            fatalError("Could not dequeue FilterScreenCell")
        }

        let filterTitle = filterTitles[indexPath.row]
        let selectedOption = selectedValue(for: filterTitle)
        cell.configure(with: filterTitle, selectedOption: selectedOption)

        cell.optionsButton.addAction(UIAction(title: "", handler: { [weak self] _ in
            self?.presentOptions(for: filterTitle, from: cell.optionsButton)
        }), for: .touchUpInside)

        return cell
    }

    private func presentOptions(for filter: String, from sourceButton: UIButton) {
        let options = filterOptions[filter] ?? ["N/A"]
        var actions: [UIAction] = []
        
        for option in options {
            actions.append(UIAction(title: option, handler: { [weak self] _ in
                self?.updateTag(for: filter, with: option)
                // Update the button title to reflect the selected option
                sourceButton.setTitle(option, for: .normal)
            }))
        }
        
        let menu = UIMenu(title: "", children: actions)
        sourceButton.menu = menu
        sourceButton.showsMenuAsPrimaryAction = true
    }

    private func indexPathForCellContaining(view: UIView) -> IndexPath? {
        let point = view.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: point)
    }
    
    func didSelectTag(_ tag: Tag) {
        delegate?.filterScreen(self, didSelectTag: tag)
    }
    
    private func selectedValue(for filter: String) -> String {
        switch filter {
        case "Good for Breakfast":
            return tag.goodForBreakfast
        case "Good for Lunch":
            return tag.goodForLunch
        case "Good for Dinner":
            return tag.goodForDinner
        case "Takes Reservations":
            return tag.takesReservations
        case "Vegetarian Friendly":
            return tag.vegetarianFriendly
        case "Cuisine":
            return tag.cuisine
        case "Live Music":
            return tag.liveMusic
        case "Outdoor Seating":
            return tag.outdoorSeating
        case "Free Wi-Fi":
            return tag.freeWIFI
        default:
            return "N/A"
        }
    }

    private func updateTag(for filter: String, with value: String) {
        switch filter {
        case "Good for Breakfast":
            tag.goodForBreakfast = value
        case "Good for Lunch":
            tag.goodForLunch = value
        case "Good for Dinner":
            tag.goodForDinner = value
        case "Takes Reservations":
            tag.takesReservations = value
        case "Vegetarian Friendly":
            tag.vegetarianFriendly = value
        case "Cuisine":
            tag.cuisine = value
        case "Live Music":
            tag.liveMusic = value
        case "Outdoor Seating":
            tag.outdoorSeating = value
        case "Free Wi-Fi":
            tag.freeWIFI = value
        default:
            break
        }
    }

}

