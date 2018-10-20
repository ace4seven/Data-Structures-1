//
//  SearchOptionsController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit
import GoodSwift

// MARK: - Enums

enum OptionType {
    case task(Option)
    case task3(Option)
    case task7(Option)
    case task8(Option)
    case task9(Option)
    case task15(Option)
}

class SearchOptionsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var items = [OptionType]()
    fileprivate var viewModel = SearchOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        setupView()
        
        viewModel.setup(delegate: self)
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerCell(fromClass: OptionCell.self)
        
        tableView.contentInset.top = 20
    }
    
    private func setupView() {
        title = "Vyhľadávanie"
    }

}

extension SearchOptionsController: SearchOptionsViewDelegate {
    
    func showOptions(tasks: [OptionType]) {
        self.items = tasks
        
        tableView.reloadData()
    }
    
}

extension SearchOptionsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .task(let option):
            let cell = tableView.dequeueReusableCell(fromClass: OptionCell.self, for: indexPath)
            cell?.setupCell(option: option)
            return cell ?? UITableViewCell()
        default: break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
