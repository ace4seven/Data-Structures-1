//
//  PropertyDetailController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PropertyDetailController: UIViewController {
    
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var propertyIDLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ownerListIDLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var items = [Share]()
    
    var viewModel: PropertyDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        viewModel?.setup(viewDelegate: self)
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = self.tableHeaderView
        tableView.registerCell(fromClass: ShareCell.self)
    }
    
}

extension PropertyDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: ShareCell.self, for: indexPath) {
            cell.setup(share: items[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
}

extension PropertyDetailController: PropertyDetailViewDelegate {
    
    func showProperty(property: Property) {
        propertyIDLabel.text = property.id.toString
        addressLabel.text = property.address
        descLabel.text = property.desc
        ownerListIDLabel.text = property.ownedList.id.toString
        
        items = property.ownedList.shares.inOrderToArray()
        
        tableView.reloadData()
    }
    
}
