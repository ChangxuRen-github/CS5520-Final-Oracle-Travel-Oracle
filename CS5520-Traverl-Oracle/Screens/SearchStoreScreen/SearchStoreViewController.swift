//
//  SearchStoreViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 12/3/23.
//

import UIKit

class SearchStoreViewController: UIViewController {
    // initialize view
    private let searchStoreView = SearchStoreView()
    // store list
    private var stores: [Store] = []
    // filtered stores
    private var results: [Store] = []
    // flag to indicate if we have fetched stores before
    private var hasFetchedStoresFromFirestore = false
    // search bar
    let searchBar: UISearchBar = UIElementUtil.createSearchBar(placeHolder: "Search for stores...")
    
    // Spinner
    private let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = searchStoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#b34538")
        searchStoreView.searchResultTableView.separatorStyle = .none
        setupNavBar()
        setupSearchBar()
        doTabelViewDelegations()
    }
}

// MARK: - Setups
extension SearchStoreViewController {
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(clearSearchBar))
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
}

// MARK: - Action listeners
extension SearchStoreViewController {
    @objc func clearSearchBar() {
        print("Clear search bar.")
        searchBar.text = ""
        searchBar.resignFirstResponder()
        results.removeAll()
        searchStoreView.searchResultTableView.reloadData()
        showSearchResults()
    }
}

// MARK: - Search bar management
extension SearchStoreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        results.removeAll()
        searchStores(query: text)
    }

    func searchStores(query: String) {
        self.showActivityIndicator()
        if (hasFetchedStoresFromFirestore) {
            filterStores(with: query)
        } else {
            DBManager.dbManager.fetchAllStores { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedStores):
                        self?.hasFetchedStoresFromFirestore = true
                        self?.stores = fetchedStores
                        self?.filterStores(with: query)
                        
                    case .failure(let error):
                        print("Error fetching stores: \(error)")
                    }
                }
            }
        }
    }

    func filterStores(with term: String) {
        self.hideActivityIndicator()
        let lowercasedTerm = term.lowercased()
        self.results = stores.filter { store in
            let name = store.displayName.lowercased()
            let category = store.category.lowercased()
            return name.hasPrefix(lowercasedTerm) || category.hasPrefix(lowercasedTerm)
        }
        showSearchResults()
    }

    func showSearchResults() {
        if (results.isEmpty) {
            searchStoreView.emptyResultLabel.isHidden = false
            searchStoreView.searchResultTableView.isHidden = true
        } else {
            searchStoreView.emptyResultLabel.isHidden = true
            searchStoreView.searchResultTableView.isHidden = false
            searchStoreView.searchResultTableView.reloadData()
        }
    }
}

// MARK: - Table view management
extension SearchStoreViewController: UITableViewDelegate, UITableViewDataSource {
    func doTabelViewDelegations() {
        searchStoreView.searchResultTableView.delegate = self
        searchStoreView.searchResultTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStoreTableViewCell.IDENTIFIER,
                                                 for: indexPath) as! SearchStoreTableViewCell
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storeDetailViewController = StoreDetailViewController(with: stores[indexPath.row])
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}

// MARK: - Spinner
extension SearchStoreViewController: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
