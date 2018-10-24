//
//  ListingPersonController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ListingPersonController: UIViewController {
    
    @IBOutlet weak var regionIDTextField: UITextField!
    @IBOutlet weak var propertyIDTextField: UITextField!
    @IBOutlet weak var ownedListIDTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Výpis osôb"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController, let persons = sender as? [Person] {
            vc.viewModel = ListViewModel(values: persons.map { ListType.person($0) })
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        guard let regionID = UInt(regionIDTextField.text ?? ""), let propertyID = UInt(propertyIDTextField.text ?? ""), let ownedListID = UInt(ownedListIDTextField.text ?? "") else {
            composeAlert(title: "Upozornenie", message: "Zle vyplnene polia", completion: { _ in })
            return
        }
        
        guard let persons = Database.shared.getPersonList(regionID: regionID, ownedListID: ownedListID, propertyID: propertyID) else {
            composeAlert(title: "Pozor", message: "Nenašli sa žiadne záznamy obyvateľov s danými parametrami", completion: { _ in })
            return
        }
        
        performSegue(withIdentifier: String(describing: ListController.self), sender: persons)
    }
    
}
