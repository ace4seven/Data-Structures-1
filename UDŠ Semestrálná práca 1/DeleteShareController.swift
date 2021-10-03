//
//  DeleteShareController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/25/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class DeleteShareController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var regionIDTextfield: UITextField!
    @IBOutlet weak var personalIDTextfield: UITextField!
    @IBOutlet weak var ownerListIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        title = "Odstránenie majetkového podielu"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController {
            if let regions = sender as? [Region] {
                let viewModel = ListViewModel(values: regions.map { .region($0) })
                vc.viewModel = viewModel
            }
            
            if let persons = sender as? [Person] {
                let viewModel = ListViewModel(values: persons.map { .person($0) })
                vc.viewModel = viewModel
            }
        }
        
        if let vc = segue.destination as? ConfirmNewSharesController, let ownerList = sender as? OwnedList {
            let viewModel = ConfirmNewSharesViewModel(ownedList: ownerList)
            vc.viewModel = viewModel
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        guard let regionID = UInt(regionIDTextfield.text ?? ""), let personalID = personalIDTextfield.text,
            let ownerListID = UInt(self.ownerListIdTextField.text ?? "") else {
                composeAlert(title: "Chyba", message: "Formulár zle vyplnený", completion: { _ in })
                return
        }
        
        if let ownerList = Database.shared.deletePersonShare(personID: personalID, regionID: regionID, ownerListID: ownerListID) {
             self.performSegue(withIdentifier: String(describing: ConfirmNewSharesController.self), sender: ownerList)
            return
        }
        
        composeAlert(title: "Upozornenie", message: "Majetkovy podiel nebol vymazany, pretoze sa nenasiel dany list vlastnictva na ktorom by bol obcan s danym ID evidovany", completion: { _ in })
    }
    
    @IBAction func regionListButtonPressed(_ sender: Any) {
        Database.shared.getRegionsSortedByName() { [weak self] regions in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
        }
    }
    
    @IBAction func personListButtonPressed(_ sender: Any) {
        Database.shared.getPersons() { [weak self] persons in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: persons)
        }
    }
    
}
