//
//  StoreListViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/29/23.
//

import UIKit

class StoreListViewController: UIViewController {
    // initialize store list view
    private let storeListView = StoreListView()
    // stores data model
    private var stores:[Store] = []
    // category of stores
    private var category: String
    // title of store list screen
    private var pageTitle: String
    
    init(with pageTitle: String, with category: String) {
        self.pageTitle = pageTitle
        self.category = category
        super.init(nibName: nil, bundle: nil)
        // TODO: initilize stores array - Done
        initializeStores()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = storeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        storeListView.storeTableView.separatorStyle = .none
        doDelegations()
    }
}

// MARK: - setups
extension StoreListViewController {
    private func setupNavBar() {
        self.title = pageTitle
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    private func initializeStores() {
        DBManager.dbManager.fetchStoresByCategory(category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedStores):
                    self?.stores = fetchedStores
                    self?.storeListView.storeTableView.reloadData()
                case .failure(let error):
                    print("Error fetching stores: \(error)")
                }
            }
        }
    }
}

//MARK: - TableView management
extension StoreListViewController: UITableViewDelegate, UITableViewDataSource {
    // do delegations
    func doDelegations() {
        storeListView.storeTableView.delegate = self
        storeListView.storeTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.IDENTIFIER, for: indexPath) as! StoreTableViewCell
        cell.configure(with: stores[indexPath.row])
        return cell
    }
    
    // TODO: swith to StoreDetailViewController - Done
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storeDetailViewController = StoreDetailViewController(with: stores[indexPath.row])
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}

