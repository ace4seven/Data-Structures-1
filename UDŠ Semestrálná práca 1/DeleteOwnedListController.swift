//
//  DeleteOwnedListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/27/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class DeleteOwnedListController: UIViewController {
    
    @IBOutlet weak var deletedOwnedListIDTextField: UITextField!
    @IBOutlet weak var regionIDTextField: UITextField!
    @IBOutlet weak var newOwnedListIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Vymazanie listu vlastníctva"
        
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OwnedListDetailController, let ownerList = sender as? OwnedList {
            let viewModel = OwnedListDetailViewModel(ownedList: ownerList, properties: ownerList.properties.inOrderToArray(), shares: ownerList.shares.inOrderToArray())
            
            vc.viewModel = viewModel
        }
    }
    
    // Po vymazani sa zobrazi detail noveho listu vlastnictva
    @IBAction func removeButtonPressed(_ sender: Any) {
        guard let deletedOwnerListID = UInt(deletedOwnedListIDTextField.text ?? ""), let newOwnedListID = UInt(newOwnedListIDTextField.text ?? ""), let regionID = UInt(regionIDTextField.text ?? "") else {
            composeAlert(title: "Upozornenie", message: "Vstupné parametre v zlom formáte, skúste znova", completion: { _ in })
            return
        }
        
        guard let ownerList = Database.shared.removeOwnedList(oldOwnerListID: deletedOwnerListID, newOnwerListID: newOwnedListID, regionID: regionID) else {
            composeAlert(title: "Chyba", message: "Neboli správne zadané listy vlastníctva v danom regione", completion: { _ in  })
            return
        }
        
        performSegue(withIdentifier: String(describing: OwnedListDetailController.self), sender: ownerList)
    }
    
}
