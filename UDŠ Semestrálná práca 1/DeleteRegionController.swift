//
//  DeleteRegionController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/27/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class DeleteRegionController: UIViewController {

    @IBOutlet weak var deletedRegionIDTextField: UITextField!
    @IBOutlet weak var movedRegionIDTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Zmazanie katastrálneho územia"
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        guard let deletedRegionID = UInt(deletedRegionIDTextField.text ?? ""), let movedRegionID = UInt(movedRegionIDTextField.text ?? "") else {
            composeAlert(title: "Chyba", message: "Vstupné údaje zle zadané, skúste znova", completion: { _ in })
            return
        }
        
        if let deletedRegion = Database.shared.deleteRegion(deletedRegionID: deletedRegionID, movedRegionID: movedRegionID) {
            composeAlert(title: "Úspech", message: "Katastrálne územie s ID: \(deletedRegion.regionID) a názvom \(deletedRegion.regionName) bolo úspešne vymazané a agenda presunutá do katastrálneho územia číslo: \(movedRegionID)", completion: {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        }
    }
    
}
