//
//  SaveScreenViewController.swift
//  CS5520-Traverl-Oracle
//
//  Created by XIN JIN on 12/3/23.
//

import UIKit

class SavedStoreViewController: UIViewController {
    // initialize saved store view
    private let savedStoreView = SavedStoreView()
    // current user
    private var user: User?
    // saved stores
    private var savedStores: [Store] = []
    // spinner
    private let childProgressView = ProgressSpinnerViewController()

    
    override func loadView() {
        view = savedStoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#b34538")

        title = "Saved Stores"
        doDelegations()
        fetchUserAndSavedStores()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserAndSavedStores()
    }
}

// MARK: - Setups
extension SavedStoreViewController {
    // initialize user
    private func fetchUserAndSavedStores() {
        guard let uwUser = AuthManager.shared.currentUser else {
            AlertUtil.showErrorAlert(viewController: self,
                                     title: "Error!",
                                     errorMessage: "Please sign in.")
            return
        }
        self.showActivityIndicator()
        DBManager.dbManager.getUser(withUID: uwUser.uid) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let user):
                self?.user = user
                self?.fetchSavedStores()
            case .failure(let error):
                print("Error fetching user details: \(error)")
            }
        }
    }
    // fetch saved stores
    private func fetchSavedStores() {
        guard let uwUser = user else {
            AlertUtil.showErrorAlert(viewController: self, title: "Error!", errorMessage: "Please sign in.")
            return
        }
        self.showActivityIndicator()
        DBManager.dbManager.fetchSavedStores(for: uwUser) { result in
            self.hideActivityIndicator()
            switch result {
            case .success(let stores):
                self.savedStores = stores
                self.savedStoreView.tableView.reloadData()
            case .failure(let error):
                print("Error fetching stores: \(error)")
            }
        }
    }
}

// MARK: - Table view management
extension SavedStoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func doDelegations() {
        savedStoreView.tableView.delegate = self
        savedStoreView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedStoreScreenTableViewCell.IDENTIFIER, for: indexPath) as! SavedStoreScreenTableViewCell
        cell.configure(with: savedStores[indexPath.row])
        // MARK: Creating an accessory button...
        let buttonOptions = UIButton(type: .system)
        // Set the frame of the button with desired width and height
        let buttonWidth: CGFloat = 30
        let buttonHeight: CGFloat = 30
        buttonOptions.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)

        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        buttonOptions.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        buttonOptions.tintColor = .systemRed
        buttonOptions.menu = UIMenu(title: "",
                                    children: [
                                        UIAction(title: "Delete", handler: { (_) in
                                            self.confirmDeleteAction(for: self.savedStores[indexPath.row], for: indexPath.row)
                                        })
                                    ])
        cell.accessoryView = buttonOptions
        cell.imageView?.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }

    func confirmDeleteAction(for store: Store, for index: Int) {
        let alertController = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this store?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteStore(at: index, with: store)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func deleteStore(at index: Int, with store: Store) {
        self.showActivityIndicator()
        DBManager.dbManager.removeStoreFromSaved(for: user!.uid, storeId: store.id) { [weak self] success in
            self?.hideActivityIndicator()
            if success {
                self?.savedStores.remove(at: index)
                self?.savedStoreView.tableView.reloadData()
                print("Store removed from saved stores")
            } else {
                print("Failed to remove store from saved stores")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storeDetailViewController = StoreDetailViewController(with: savedStores[indexPath.row])
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}

// MARK: - Spinner
extension SavedStoreViewController: ProgressSpinnerDelegate {
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
