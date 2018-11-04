//
//  AddPropertyToOwnListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/22/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class AddPropertyToOwnListController: UIViewController {
    
    @IBOutlet weak var propertyIDTextField: UITextField!
    @IBOutlet weak var regionIDTextField: UITextField!
    @IBOutlet weak var ownerListIDTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func addPropertyButtonPressed(_ sender: Any) {
        guard
            let regionID = UInt(regionIDTextField.text ?? ""),
            let ownerListID = UInt(ownerListIDTextField.text ?? ""),
            let propertyID = UInt(propertyIDTextField.text ?? ""),
            let address = adressTextField.text,
            let desc = descTextView.text else {
            composeAlert(title: "Chyba", message: "Vyplňte všetky polia") { _ in }
            return
        }
        
        if Database.shared.addProperty(regionID: regionID, ownerListID: ownerListID, propertyID: propertyID, address: address, desc: desc) {
            composeAlert(title: "Úspech", message: "Nehnuteľnosť úspešne zapísaná") { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            composeAlert(title: "Chyba", message: "Nehnutelnost nieje mozne zapísať") { _ in }
        }
        
    }
    

}
