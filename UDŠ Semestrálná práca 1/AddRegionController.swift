//
//  AddRegionController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/22/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class AddRegionController: UIViewController {
    
    @IBOutlet weak var regionNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController {
            if let regions = sender as? [Region] {
                let viewModel = ListViewModel(values: regions.map { .region($0) })
                vc.viewModel = viewModel
            }
        }
    }
    
    @IBAction func regionListButtonPressed(_ sender: Any) {
        Database.shared.getRegionsSortedByName() { [weak self] regions in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
        }
    }
    
    @IBAction func addRegionButtonPressed(_ sender: Any) {
        guard let regionName = regionNameTextField.text else { return }
        
        if Database.shared.addRegion(name: regionName) {
            composeAlert(title: "Úspech", message: "Región bol úspešne pridaný") { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            composeAlert(title: "Chyba", message: "Región s daným menom už je registrovaný") { _ in }
        }
    }
    
}
