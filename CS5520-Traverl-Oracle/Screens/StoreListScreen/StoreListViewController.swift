//
//  StoreListViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class StoreListViewController: UIViewController {
    
    let storeListView = StoreListView()
    
    var stores = [Store]()
    
    // click different buttons will show different Store List Title and FrontSize
    var pageTitle: String?
    var pageTitleFontSize: CGFloat = Constants.FONT_REGULAR
    
    override func loadView() {
        view = storeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the different title and frontsize for the store list
        setTitleAndStyle()
        
        //MARK: Removing separator line from TableView...
        storeListView.storeTableView.separatorStyle = .none
        
        //MARK: patching the table view delegate and datasource to controller...
        storeListView.storeTableView.delegate = self
        storeListView.storeTableView.dataSource = self
    }
    
    func setTitleAndStyle() {
            self.title = pageTitle
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: pageTitleFontSize),
                .foregroundColor: UIColor.black
            ]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        }
    }

//MARK: adopting the procols for TableView...
extension StoreListViewController: UITableViewDelegate, UITableViewDataSource {
    //there is no effect when you click the tableview cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stores", for: indexPath) as! StoreTableViewCell
    
        let store = stores[indexPath.row]
        cell.storeDisplayNameLabel.text = store.displayName
        cell.storeCreatedAtLabel.text = DateFormatter.formatDate(store.createdAt)
        //TODO: NEE TO CHANGE TO LOCATION LATER
        cell.storeLocationLabel.text = store.displayName
        
        //MARK: setting the image of the receipt...
        // Load the first image if available
        if !store.images.isEmpty {
            let firstImageUrl = store.images[0]
            if let url = URL(string: firstImageUrl), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                cell.imageReceipt.image = image
            } else {
                cell.imageReceipt.image = nil  // Set a default image or leave it blank
            }
        }
        return cell
    }
    
    // TODO: swith to StoreDetailViewController later
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storeDetailViewController = StoreDetailViewController()
//        storeDetailViewController.receivedInformation = stores[indexPath.row]
//        storeDetailViewController.delegate = self
//        storeDetailViewController.selectedIndex = indexPath.row
//        navigationController?.pushViewController(storeDetailViewController, animated: true)
//    }
}

