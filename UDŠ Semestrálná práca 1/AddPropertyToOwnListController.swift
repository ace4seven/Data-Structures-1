//
//  AddPropertyToOwnListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/22/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class AddPropertyToOwnListController: UIViewController {
    
    @IBOutlet weak var regionIDTextField: UITextField!
    @IBOutlet weak var ownerListIDTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addPropertyButtonPressed(_ sender: Any) {
        guard
            let regionID = UInt(regionIDTextField.text ?? ""),
            let ownerListID = UInt(ownerListIDTextField.text ?? ""),
            let address = adressTextField.text,
            let desc = descTextView.text else {
            composeAlert(title: "Chyba", message: "Vyplňte všetky polia") { _ in }
            return
        }
        
        guard let region = Database.shared.getRegion(regionID: regionID) else {
            composeAlert(title: "Pozor", message: "Region s daným ID neexistuje", completion: {_ in})
            return
        }
        
        Database.shared.getOwnerList(regionID: region.regionID, ownerListID: ownerListID) { [weak self] result in
            
            guard let ownerList = result else {
                self?.composeAlert(title: "Chyba", message: "Zadany list vlastnictva sa v danom regione nenašiel", completion: { _ in })
                return
            }
            
            if ownerList.addProperty(property: Property(id: DataSeeder.propertyID(), address: address, desc: desc, ownedList: ownerList)) {
                self?.composeAlert(title: "Úspech", message: "Nehnuteľnosť bola úspešne zaradená do listu vlastníctva") { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                self?.composeAlert(title: "Chyba", message: "Nehnuteľnosť už bola zaregistrovaná", completion: { _ in })
            }
        }
        
    }
    

}

extension AddPropertyToOwnListController {
    
    
    
}
