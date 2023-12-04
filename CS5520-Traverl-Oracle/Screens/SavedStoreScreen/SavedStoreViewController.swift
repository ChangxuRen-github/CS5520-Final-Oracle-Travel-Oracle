//
//  SaveScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 12/3/23.
//

import UIKit

class SaveScreenViewController: UIViewController {
    let saveScreen = SaveScreenView()
    var storesList = [(displayName: "Store 1", description: "Description for Store 1", images: ["https://example.com/image1.jpg"]),
                      (displayName: "Store 2", description: "Description for Store 2", images: ["https://example.com/image2.jpg"])]
    
    override func loadView() {
        view = saveScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Stores"
        
        saveScreen.tableView.delegate = self
        saveScreen.tableView.dataSource = self

    }
    
    @objc func heartButtonTapped(sender: UIButton) {
        print("Heart button tapped")
        let cell = sender.superview as! SaveScreenViewCell
        if let indexPath = saveScreen.tableView.indexPath(for: cell) {
            
            let alertController = UIAlertController(
                title: "Confirm Delete",
                message: "Are you sure you want to delete this store?",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.storesList.remove(at: indexPath.row)
                self.saveScreen.tableView.deleteRows(at: [indexPath], with: .fade)
                self.saveScreen.tableView.reloadData()
            }
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true, completion: nil)

        }
        
    }
    

}

extension SaveScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsList", for: indexPath) as! SaveScreenViewCell
        cell.labelTitle.text = storesList[indexPath.row].displayName
        cell.labelDescription.text = storesList[indexPath.row].description
        
        // MARK: Creating an accessory button...
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        // MARK: Setting an icon from sf symbols...
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        
        // MARK: Setting up a menu for button options click...
        buttonOptions.menu = UIMenu(title: "",
                                    children: [
                                        UIAction(title: "Delete", handler: { (_) in
                                            self.confirmDeleteAction(for: indexPath.row)
                                        })
                                    ])
        // MARK: Setting the button as an accessory of the cell...
        cell.accessoryView = buttonOptions
        
        let imageUrlString = storesList[indexPath.row].images[0]
        if let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.profileImageView?.image = image
                    }
                }
            }.resume()
        }
        
        cell.imageView?.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }

    func confirmDeleteAction(for index: Int) {
        let alertController = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this store?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteStore(at: index)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func deleteStore(at index: Int) {
        if index >= 0 && index < storesList.count {
            storesList.remove(at: index)
            saveScreen.tableView.reloadData()
        }
    }

}

