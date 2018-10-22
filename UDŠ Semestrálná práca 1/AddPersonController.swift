//
//  AddPersonController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/22/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class AddPersonController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var personalIDTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        title = "Pridanie občana"
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
        guard let personalID = self.personalIDTextfield.text, let name = self.nameTextfield.text, let surname = self.lastnameTextfield.text else {
            composeAlert(title: "Chyba", message: "Musite vyplniť všetky parametre", completion: { _ in })
            return
        }
        
        if personalID.trimmingCharacters(in: .whitespaces).count != 16 {
            composeAlert(title: "Chybs", message: "Rodné číslo musí mať presne 16 znakov", completion: {_ in})
            return
        }
        
        if Database.shared.addPerson(personalID: personalID, name: name, surname: surname, dateOfBirth: Int(datePicker.date.timeIntervalSince1970)) {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            composeAlert(title: "Chyba", message: "Občan so zadaným rodným číslom už je v systéme evidovaný", completion: {_ in})
        }
        
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
