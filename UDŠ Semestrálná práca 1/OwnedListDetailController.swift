//
//  OwnedListDetailController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

enum OwnedListCellType {
    case property(Property)
    case share(Share)
}

class OwnedListDetailController: UIViewController {
    
    @IBOutlet var ownedListView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ownedListIDLabel: UILabel!
    @IBOutlet weak var propertiesCountLabel: UILabel!
    @IBOutlet weak var personsCountLabel: UILabel!
    
    fileprivate var items = [Int: [OwnedListCellType]]()
    
    var viewModel: OwnedListDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.viewModel?.setup(viewDelegate: self)
    }
    
    private func setupView() {
        tableView.registerCell(fromClass: ShareCell.self)
        tableView.registerCell(fromClass: PropertyCell.self)
        tableView.tableHeaderView = ownedListView
    }

}

extension OwnedListDetailController: OwnedListDetailViewDelegate {
    
    func showItems(ownedList: OwnedList, properties: [Property], shares: [Share]) {
        ownedListIDLabel.text = ownedList.id.toString
        propertiesCountLabel.text = "\(properties.count)"
        personsCountLabel.text = "\(shares.count)"
        
        items.removeAll()
        items[0] = properties.map { .property($0)}
        items[1] = shares.map { .share($0)}
        
        tableView.reloadData()
    }
    
}

extension OwnedListDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let types = items[indexPath.section] else {
            return UITableViewCell()
        }
        
        switch types[indexPath.row] {
        case .property(let property):
            if let cell = tableView.dequeueReusableCell(fromClass: PropertyCell.self, for: indexPath) {
                cell.setupCell(property: property)
                return cell
            }
        case .share(let share):
            if let cell = tableView.dequeueReusableCell(fromClass: ShareCell.self, for: indexPath) {
                cell.setup(share: share)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Zoznam nehnuteľností na liste vlastníctva" : "Zoznam majiteľov"
    }
    
}
