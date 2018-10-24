//
//  SearchPersonController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class SearchPersonController: UIViewController {
    
    @IBOutlet weak var personIDTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Vyhľadávanie osoby"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PersonDetailController, let person = sender as? Person {
            let viewModel = PersonDetailViewModel(person: person)
            vc.viewModel = viewModel
        }
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        Database.shared.searchPerson(personID: personIDTextField.text ?? "") { [weak self] result in
            guard let person = result else {
                composeAlert(title: "Upozornenie", message: "Občan s daným rodným číslom sa nenašiel", completion: { _ in })
                return
            }
            self?.performSegue(withIdentifier: String(describing: PersonDetailController.self), sender: person)
        }
    }
}
