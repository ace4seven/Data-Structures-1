//
//  ControlPersonListConstroller.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

enum ControlPersonItemType {
    case person(Person)
    case share(Share)
}

class ControlPersonListController: UIViewController {
    
    @IBOutlet var ownedHeaderView: UIView!
    
    @IBOutlet var propertyHeaderView: UIView!
    
    @IBOutlet weak var propertyIDLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ownedListIDLabel: UILabel!
    
    fileprivate var items = [ControlPersonItemType]()
    
    var viewModel: ControlPersonListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Zoznam osôb"
        
        viewModel?.setup(viewDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc =  segue.destination as? ControlOwnerListController, let person = sender as? Person {
            let viewModel = ControlOwnerListViewModel(type: .person(person))
            vc.viewModel = viewModel
        }
    }

}

extension ControlPersonListController: ControlPersonViewDelegate {
    
    func showOwnedListHeader(ownedList: OwnedList) {
        ownedListIDLabel.text = "\(ownedList.id)"
        tableView.tableHeaderView = ownedHeaderView
    }
    
    func showSharePersons(shares: [Share]) {
        items = shares.map{ .share($0) }
        tableView.reloadData()
    }
    
    
    func goToPersonOwnedLists(person: Person) {
        performSegue(withIdentifier: String(describing: ControlOwnerListController.self), sender: person)
    }
    
    func showPersons(persons: [Person]) {
        self.items = persons.map { ControlPersonItemType.person($0) }
        tableView.reloadData()
    }
    
    func showPropertyHeader(property: Property) {
        propertyIDLabel.text = "\(property.id)"
        tableView.tableHeaderView = propertyHeaderView
    }
    
}

extension ControlPersonListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: ControlPersonCell.self, for: indexPath) {
            cell.delegate = self.viewModel
            switch items[indexPath.row] {
            case .person(let person):
                cell.setupCell(person: person)
            case .share(let share):
                cell.setupCell(person: share.person, share: share.shareCount)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
}
