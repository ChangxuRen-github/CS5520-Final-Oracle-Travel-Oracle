//
//  FilterScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 11/28/23.
//

import UIKit

class FilterScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    
    var tag: Tag = Tag(goodForBreakfast: "All", goodForLunch: "All", goodForDinner: "All", takesReservations: "All", vegetarianFriendly: "All", cuisine: "All", liveMusic: "All", outdoorSeating: "All", freeWIFI: "All")
    
    let filterTitles: [String] = [
        "Good for Breakfast", "Good for Lunch", "Good for Dinner",
        "Takes Reservations", "Vegetarian Friendly", "Cuisine",
        "Live Music", "Outdoor Seating", "Free Wi-Fi"
    ]
    
    let filterOptions: [String: [String]] = [
        "Good for Breakfast": ["All", "Yes", "No"],
        "Good for Lunch": ["All", "Yes", "No"],
        "Good for Dinner": ["All", "Yes", "No"],
        "Takes Reservations": ["All", "Yes", "No"],
        "Vegetarian Friendly": ["All", "Yes", "No"],
        "Cuisine": ["All", "Italian", "Chinese", "American", "Other"],
        "Live Music": ["All", "Yes", "No"],
        "Outdoor Seating": ["All", "Yes", "No"],
        "Free Wi-Fi": ["All", "Yes", "No"]
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
        let options = filterOptions[filter] ?? ["All"]
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
    
    private func selectedValue(for filter: String) -> String {
        // 
        return "All"
    }

    private func updateTag(for filter: String, with value: String) {
        //
    }
}

