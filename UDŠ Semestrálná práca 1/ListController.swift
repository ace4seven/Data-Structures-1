//
//  ListController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListVM?
    
    fileprivate var items = [ListType]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        viewModel?.setup(viewDelegate: self)
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCell(fromClass: PropertyCell.self)
        tableView.registerCell(fromClass: RegionCell.self)
    }

}

// MARK: - List view Delegate

extension ListController: ListViewDelegate {
    
    func showData(items: [ListType]) {
        self.items = items
        tableView.reloadData()
    }
    
}

// MARK: - Table View delegate, datasource

extension ListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .property(let property):
            if let cell = tableView.dequeueReusableCell(fromClass: PropertyCell.self, for: indexPath) {
                cell.setupCell(property: property)
                return cell
            }
        case .region(let region):
            if let cell = tableView.dequeueReusableCell(fromClass: RegionCell.self, for: indexPath) {
                cell.setupCell(region: region)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
}
