//
//  SearchOwnedListController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class SearchOwnedListController: UIViewController {
    
    @IBOutlet weak var searchRegionTitle: UILabel!
    @IBOutlet weak var retionOrNameTextfield: UITextField!
    
    @IBOutlet weak var ownedListIDTextField: UITextField!
    fileprivate var searchByID: Bool!
    
    var viewModel: SearchOwnedListVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        title = "Vyhľadávanie nehnuteľností"
        self.viewModel?.setup(viewDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OwnedListDetailController, let data = sender as? OwnedListData {
            let viewModel = OwnedListDetailViewModel(ownedList: data.ownedList, properties: data.properties, shares: data.shares)
            vc.viewModel = viewModel
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let regionID = UInt(retionOrNameTextfield.text ?? "")
        let regionName = retionOrNameTextfield.text
        
        guard let ownedListID = UInt(ownedListIDTextField.text ?? "") else {
            composeAlert(title: "Chyba", message: "Číslo listu vlastníctva musí byť číslo", completion: { _ in} )
            return
        }
        
        guard let ownerListData = Database.shared.searchOwnedList(key: searchByID ? RegionSearchKey.id(regionID ?? 0) : RegionSearchKey.name(regionName ?? ""), ownedListID: ownedListID) else {
            composeAlert(title: "Upzornenie", message: "List vlastnictva sa nenasiel", completion: { _ in})
            return
        }
        
        performSegue(withIdentifier: String(describing: OwnedListDetailController.self), sender: ownerListData)
        
    }
    
    
}

extension SearchOwnedListController: SearchOwnedListViewDelegate {
    
    func setupView(searchByID: Bool) {
        self.searchByID = searchByID
        
        self.searchRegionTitle.text = searchByID ? "Zadajte id katastrálneho územia" : "Zadajte meno katastralného územia"
        self.retionOrNameTextfield.keyboardType = searchByID ? UIKeyboardType.numberPad : UIKeyboardType.default
        
    }
    
}
