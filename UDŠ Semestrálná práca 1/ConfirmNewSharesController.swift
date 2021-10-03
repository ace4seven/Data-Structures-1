//
//  ConfirmNewSharesController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit
import GoodSwift

class ConfirmNewSharesController: UIViewController {
    
    var viewModel: ConfirmNewSharesVM?
    
    var items: [Share] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        viewModel?.setup(viewDelegate: self)
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.viewModel?.save()
    }
    
}

extension ConfirmNewSharesController: ConfirmNewSharesViewDelegate {
    
    func errorSaveMessage() {
        composeAlert(title: "Chyba", message: "Uloženie sa nepodarilo, pretože výsledna suma je viac ako 100 percent", completion: { _ in })
    }
    
    func confirmSuccessMessage() {
        composeAlert(title: "Úspech", message: "Úprava bola úspešne dokončená", completion: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    
    func showItems(items: [Share]) {
        self.items = items
        tableView.reloadData()
    }
    
}

extension ConfirmNewSharesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(fromClass: EditShareCell.self, for: indexPath) {
            cell.delegate = viewModel
            cell.setup(share: items[indexPath.row], index: indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
}
