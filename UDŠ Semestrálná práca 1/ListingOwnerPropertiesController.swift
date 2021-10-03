//
//  ListingOwnerPropertiesController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/25/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ListingOwnerPropertiesController: UIViewController {

    @IBOutlet weak var personIDTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        title = "Výpis nehnuteľností majitela."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController, let data = sender as? [PropertyShare] {
            let viewModel = ListViewModel(values: data.map { ListType.propertyWithShare($0) })
            vc.viewModel = viewModel
        }
    }
    
    
    @IBAction func ListingButtonPressed(_ sender: Any) {
        guard let personID = personIDTextField.text, personID.count == 16 else {
            composeAlert(title: "Chyba", message: "Zle zadané rodné číslo, musí obsahovať minimálne 16 znakov", completion: {_ in })
            return
        }
        
        guard let result = Database.shared.listOwnerProperties(personalID: personID) else {
            composeAlert(title: "Upozornenie", message: "Užívateľ s daným rodným číslom sa nenašiel", completion: {_ in})
            return
        }
        
        if result.count <= 0 {
            composeAlert(title: "Upozornenie", message: "Uživateľ nevlastní žiadne nehnuteľnosti", completion: { _ in })
        }
        
        performSegue(withIdentifier: String(describing: ListController.self), sender: result)
    }
    

}
