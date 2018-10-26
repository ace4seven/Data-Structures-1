//
//  UpdateOptionsController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class UpdateOptionsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var items = [OptionType]()
    fileprivate var viewModel = UpdateOptionsViewModel()
    
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
        title = "Zmeny v systéme"
    }
    
}

extension UpdateOptionsController: UpdateOptionsViewDelegate {
    
    func showOptions(tasks: [OptionType]) {
        self.items = tasks
        
        tableView.reloadData()
    }
    
}

extension UpdateOptionsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .task10(let option), .task11(let option), .task12(let option), .task13(let option), .task16(let option), .task17(let option), .task18(let option), .task19(let option), .task20(let option), .task21(let option), .task22(let option):
            let cell = tableView.dequeueReusableCell(fromClass: OptionCell.self, for: indexPath)
            cell?.setupCell(option: option)
            return cell ?? UITableViewCell()
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case .task10:
            performSegue(withIdentifier: String(describing: PersonNewHomeController.self), sender: nil)
        case .task12:
            performSegue(withIdentifier: String(describing: FormChangeShare.self), sender: nil)
        case .task13:
            performSegue(withIdentifier: String(describing: DeleteShareController.self), sender: nil)
        case .task16:
            performSegue(withIdentifier: String(describing: AddPersonController.self), sender: nil)
        case .task17:
            performSegue(withIdentifier: String(describing: AddOwnedListController.self), sender: nil)
        case .task18:
            performSegue(withIdentifier: String(describing: AddPropertyToOwnListController.self), sender: nil)
        case .task20:
            performSegue(withIdentifier: String(describing: DeletePropertyController.self), sender: nil)
        case .task21:
            performSegue(withIdentifier: String(describing: AddRegionController.self), sender: nil)
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
