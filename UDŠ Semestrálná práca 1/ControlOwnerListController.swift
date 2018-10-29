//
//  ControlOwnerListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ControlOwnerListController: UIViewController {
    
    @IBOutlet var regionHeaderView: UIView!
    @IBOutlet var personHeaderView: UIView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ControlOwnerListViewModel?
    
    fileprivate var items = [OwnedList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Listy vlastníctva"
        
        viewModel?.setup(viewDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ControlPersonListController, let ownerList = sender as? OwnedList {
            let viewModel = ControlPersonListViewModel(type: .ownedListPersons(ownerList))
            vc.viewModel = viewModel
        } else if let vc = segue.destination as? ControlPropertiesController, let ownedList = sender as? OwnedList {
            let viewModel = ControlPropertyViewModel(type: .ownedList(ownedList))
            vc.viewModel = viewModel
        }
    }
    
}

extension ControlOwnerListController: ControlOwnerListViewDelegate {
    
    func gotoPersons(ownedList: OwnedList) {
        performSegue(withIdentifier: String(describing: ControlPersonListController.self), sender: ownedList)
    }
    
    func goToProperties(ownedList: OwnedList) {
        performSegue(withIdentifier: String(describing: ControlPropertiesController.self), sender: ownedList)
    }
    
    func showHeader(for type: ControlOwnerType) {
        switch type {
        case .person(let person):
            tableView.tableHeaderView = personHeaderView
            personNameLabel.text = person.fullName
        case .region(let region):
            tableView.tableHeaderView = regionHeaderView
            regionNameLabel.text = region.regionName
        }
    }
    
    func showOwnerLists(items: [OwnedList]) {
        self.items = items
        tableView.reloadData()
    }
    
}

extension ControlOwnerListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: ControlOwnerCell.self, for: indexPath) {
            cell.delegate = viewModel
            cell.setupCell(ownedList: items[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
}
