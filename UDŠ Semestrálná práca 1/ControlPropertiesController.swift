//
//  ControlPropertiesController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ControlPropertiesController: UIViewController {
    @IBOutlet var ownedListHeaderView: UIView!
    
    @IBOutlet var regionHeaderView: UIView!
    
    @IBOutlet weak var ownedListIDLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var regionNameLabel: UILabel!
    
    fileprivate var items = [Property]()
    
    var viewModel: ControlPropertyViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Zoznam nehnuteľností"
        
        viewModel?.setup(viewDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ControlPersonListController, let property = sender as? Property {
            let viewModel = ControlPersonListViewModel(type: .propertyPersons(property))
            vc.viewModel = viewModel
        }
    }

}

extension ControlPropertiesController: ControlPropertyViewDelegate {
    
    func goToPersonList(property: Property) {
        performSegue(withIdentifier: String(describing: ControlPersonListController.self), sender: property)
    }
    
    func showRegionHeader(region: Region) {
        regionNameLabel.text = region.regionName
        tableView.tableHeaderView = regionHeaderView
    }
    
    func showOwnedListheader(ownedList: OwnedList) {
        ownedListIDLabel.text = "\(ownedList.id)"
        tableView.tableHeaderView = ownedListHeaderView
    }
    
    
    func showProperties(properties: [Property]) {
        self.items = properties
        tableView.reloadData()
    }
    
}

extension ControlPropertiesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: ControlPropertyCell.self, for: indexPath) {
            cell.setupCell(property: items[indexPath.row])
            cell.delegate = viewModel
            return cell
        }
        
        return UITableViewCell()
    }
    
}
