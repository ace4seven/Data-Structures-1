//
//  FormChangeShare.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class FormChangeShare: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var regionIDTextfield: UITextField!
    @IBOutlet weak var personalIDTextfield: UITextField!
    @IBOutlet weak var ownerListIdTextField: UITextField!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        indicator.alpha = 0.0
        title = "Pridanie osoby do listu vlastníctva"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController {
            if let regions = sender as? [Region] {
                let viewModel = ListViewModel(values: regions.map { .region($0) })
                vc.viewModel = viewModel
            }
            
            if let persons = sender as? [Person] {
                let viewModel = ListViewModel(values: persons.map { .person($0) })
                vc.viewModel = viewModel
            }
        }
        
        if let vc = segue.destination as? ConfirmNewSharesController, let ownerList = sender as? OwnedList {
            let viewModel = ConfirmNewSharesViewModel(ownedList: ownerList)
            vc.viewModel = viewModel
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
//        indicator.alpha = 1.0
//        indicator.startAnimating()
        
        guard let regionID = UInt(regionIDTextfield.text ?? ""), let personalID = personalIDTextfield.text,
            let ownerListID = UInt(self.ownerListIdTextField.text ?? "") else {
//                indicator.alpha = 0.0
//                indicator.stopAnimating()
                return
        }
        
        Database.shared.changeShare(regionID: regionID, ownerListID: ownerListID, personID: personalID) { [weak self] list in
            guard let ownedList = list else {
//                self?.indicator.alpha = 0.0
//                self?.indicator.stopAnimating()
                self?.composeAlert(title: "List vlastníctva sa nenašiel", message: "Skontrolujte, či ste zadali správne číslo katastrálneho územia, alebo číslo vlastníctva", completion: { _ in
                })
                return
            }
            self?.performSegue(withIdentifier: String(describing: ConfirmNewSharesController.self), sender: ownedList)
        }
    }
    
    @IBAction func regionListButtonPressed(_ sender: Any) {
        Database.shared.getRegionsSortedByName() { [weak self] regions in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
        }
    }
    
    @IBAction func personListButtonPressed(_ sender: Any) {
        Database.shared.getPersons() { [weak self] persons in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: persons)
        }
    }

}
