//
//  DeletePropertyController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/26/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class DeletePropertyController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var regionIDTextfield: UITextField!
    @IBOutlet weak var properyIDTextField: UITextField!
    @IBOutlet weak var ownerListIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        title = "Odstránenie nehnuteľností z listu vlastníctva"
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        actionButton.isEnabled = false
        
        guard let regionID = UInt(regionIDTextfield.text ?? ""), let propertyID = UInt(properyIDTextField.text ?? ""),
            let ownerListID = UInt(self.ownerListIdTextField.text ?? "") else {
                composeAlert(title: "Chyba", message: "Formulár zle vyplnený", completion: { _ in })
                return
        }
        
        guard let deletedProperty = Database.shared.deletePropertyFromOwnedList(regionID: regionID, ownedListID: ownerListID, propertyID: propertyID) else {
            composeAlert(title: "Upozornenie", message: "Dana nehnuteľnosť sa nenašla na danom liste vlastníctva", completion: { _ in })
            return
        }
        
        composeAlert(title: "Úspech", message: "Nehnuteľnosť so súpisným číslom: \(deletedProperty.id) bola úspešne vymazaná", completion: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
}
