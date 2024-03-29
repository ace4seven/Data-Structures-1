//
//  AddOwnedListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/22/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class AddOwnedListController: UIViewController {
    
    @IBOutlet weak var ownerListIDTextField: UITextField!
    @IBOutlet weak var regionNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    @IBAction func actionButtonPressed(_ sender: Any) {
        guard let ownerID = UInt(ownerListIDTextField.text ?? ""), let regionName = regionNameTextField.text else {
            composeAlert(title: "Chyba", message: "Zadajte všetky údaje", completion: {_ in})
            return
        }
        
        guard let region = Database.shared.getRegion(regionName: regionName) else {
            composeAlert(title: "Pozor", message: "Region s daným menom neexistuje", completion: {_ in})
            return
        }
        
        if Database.shared.addNewOwnerList(ownerListID: ownerID, for: region) {
            composeAlert(title: "Úspech", message: "List vlastníctva bol úspešne uložený", completion: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        } else {
            composeAlert(title: "Chyba", message: "Zadaný list vlastníctva už existuje v systéme", completion: {_ in})
        }
    }
    
}
