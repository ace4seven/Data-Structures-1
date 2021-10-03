//
//  ControlRegionController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ControlRegionController: UIViewController {
    
    @IBOutlet var noDataHeaderView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel: ControlRegionVM?
    
    fileprivate var regions = [Region]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Zoznam katastrálnych územíí"
        
        viewModel = ControlRegionViewModel()
        
        viewModel?.setup(viewDelegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.reload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ControlPropertiesController, let region = sender as? Region {
            let viewModel = ControlPropertyViewModel(type: .region(region))
            vc.viewModel = viewModel
        } else if let vc = segue.destination as? ControlOwnerListController, let region = sender as? Region {
            let viewModel = ControlOwnerListViewModel(type: .region(region))
            vc.viewModel = viewModel
        } else if let vc = segue.destination as? ControlPersonListController, let persons = sender as? [Person] {
            let viewModel = ControlPersonListViewModel(type: .all(persons))
            vc.viewModel = viewModel
        }
    }
    
    
    @IBAction func personsButtonPressed(_ sender: Any) {
        viewModel?.preparePersonSegue()
    }
    
}

extension ControlRegionController: ControlRegionViewDelegate {
    
    func goToAllPersons(persons: [Person]) {
        performSegue(withIdentifier: String(describing: ControlPersonListController.self), sender: persons)
    }
    
    func goToOwnedLists(for region: Region) {
         performSegue(withIdentifier: String(describing: ControlOwnerListController.self), sender: region)
    }
    
    func goToProperties(for region: Region) {
        performSegue(withIdentifier: String(describing: ControlPropertiesController.self), sender: region)
    }
    
    
    func showRegions(regions: [Region]) {
        self.regions = regions
        
        if regions.count <= 0 {
            tableView.tableHeaderView = noDataHeaderView
        } else {
            tableView.tableHeaderView = UIView(frame: .zero)
        }
        
        tableView.reloadData()
    }
    
}

extension ControlRegionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: ControlRegionCell.self, for: indexPath) {
            cell.setupCell(region: regions[indexPath.row])
            cell.delegate = viewModel
            return cell
        }
        
        return UITableViewCell()
    }
    
}
