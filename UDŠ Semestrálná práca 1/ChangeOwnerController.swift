//
//  ChangeOwnerController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/27/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ChangeOwnerController: UIViewController {
    @IBOutlet weak var newPersonIDTextField: UITextField!
    
    @IBOutlet weak var oldPersonIDTextField: UITextField!
    @IBOutlet weak var regionIDTextField: UITextField!
    
    @IBOutlet weak var propertyIDTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Zmena majiteľa"
        
        hideKeyboardWhenTappedAround()
    }

    @IBAction func changeButtonPressed(_ sender: Any) {
        guard let newPersonID = newPersonIDTextField.text, let oldPersonID = oldPersonIDTextField.text, let regionID = UInt(regionIDTextField.text ?? ""), let propertyID = UInt(propertyIDTextField.text ?? "") else {
            composeAlert(title: "Chyba", message: "Vstupné údaje sú v zlom formáte", completion: { _ in})
            return
        }
        
        if Database.shared.changePropertyOwner(oldPersonID: oldPersonID, newPersonID: newPersonID, regionID: regionID, propertyID: propertyID) {
            composeAlert(title: "Uspech", message: "Majite bol úspešne zmenený", completion: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        } else {
            composeAlert(title: "Neuspech", message: "Nepodarilo sa zmeniť nového majiteľa nehnuteľností - skontrolujte, či ste zadali správe rodné čísla, či existuje daný region a v ňom daná nehnuteľnosť.", completion: { _ in })
        }
        
        
    }
    
}
