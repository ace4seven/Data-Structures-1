//
//  PersonNewHomeController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/25/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PersonNewHomeController: UIViewController {
    
    @IBOutlet weak var personIDTextField: UITextField!
    @IBOutlet weak var regionNameTextField: UITextField!
    @IBOutlet weak var propertyIDTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PersonDetailController, let person = sender as? Person {
            let viewModel = PersonDetailViewModel(person: person)
            vc.viewModel = viewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pridanie, zmena nového trvalého bydliska"
    }
    
    
    @IBAction func ChangeHomeButtonPressed(_ sender: Any) {
        guard let personID = personIDTextField.text, let regionName = regionNameTextField.text, let propertyID = UInt(propertyIDTextField.text ?? "") else {
            composeAlert(title: "Chyba", message: "Nesprávne vstupy", completion: { _ in })
            return
        }
        
        guard let person = Database.shared.changeAddHome(for: personID, regionName: regionName, propertyID: propertyID) else {
            composeAlert(title: "Upozornenie", message: "Katastrálne územie, alebo občan, alebo nehnuteľnost sa nenašla", completion: { _ in })
            return
        }
        
        performSegue(withIdentifier: String(describing: PersonDetailController.self), sender: person)
    }
    
}
