//
//  SearchPropertyController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class SearchPropertyController: UIViewController {
    
    @IBOutlet weak var searchRegionTitle: UILabel!
    @IBOutlet weak var retionOrNameTextfield: UITextField!
    @IBOutlet weak var propertyIDTextField: UITextField!
    
    fileprivate var searchByID: Bool!
    
    var viewModel: SearchPropertyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        title = "Vyhľadávanie nehnuteľností"
        self.viewModel?.setup(viewDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PropertyDetailController, let data = sender as? Property {
            let viewModel = PropertyDetailViewModel(property: data)
            vc.viewModel = viewModel
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let regionID = UInt(retionOrNameTextfield.text ?? "")
        let regionName = retionOrNameTextfield.text
        
        guard let propertyID = UInt(propertyIDTextField.text ?? "") else {
            composeAlert(title: "Chyba", message: "Súpisné číslo musí byť číslo", completion: { _ in} )
            return
        }
        
        Database.shared.searchProperty(key: searchByID ? .id(regionID ?? 0) : .name(regionName ?? ""), propertyID: propertyID) { [weak self] findedProperty in
            guard let property = findedProperty else {
                composeAlert(title: "Upozornienie", message: "Nehnuteľnosť sa nenašla", completion: { _ in })
                return
            }
            
            self?.performSegue(withIdentifier: String(describing: PropertyDetailController.self), sender: property)
        }
    }
    

}

extension SearchPropertyController: SearchPropertyViewDelegate {
    
    func setupView(searchByID: Bool) {
        self.searchByID = searchByID
        
        self.searchRegionTitle.text = searchByID ? "Zadajte id katastrálneho územia" : "Zadajte meno katastralného územia"
        self.retionOrNameTextfield.keyboardType = searchByID ? UIKeyboardType.numberPad : UIKeyboardType.default
        
    }
    
}
