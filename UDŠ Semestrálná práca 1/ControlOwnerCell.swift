//
//  ControlOwnerCell.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol ControlOwnerCellDelegate: class {
    func goToPropertiesList(from ownerList: OwnedList)
    func goToSharesList(from ownerList: OwnedList)
}

class ControlOwnerCell: UITableViewCell {

    @IBOutlet weak var ownerListIDLabel: UILabel!
    @IBOutlet weak var propertyCountLabel: UILabel!
    @IBOutlet weak var sharesCountLabel: UILabel!
    
    fileprivate var ownedList: OwnedList?
    
    weak var delegate: ControlOwnerCellDelegate?
    
    func setupCell(ownedList: OwnedList) {
        self.ownedList = ownedList
        
        ownerListIDLabel.text = "\(ownedList.id) (Kat. ú. č: \(ownedList.region.regionID))"
        propertyCountLabel.text = "\(ownedList.properties.count)"
        sharesCountLabel.text = "\(ownedList.shares.count)"
    }
    
    @IBAction func propertiesListButtonPressed(_ sender: Any) {
        guard let list = self.ownedList else { return }
        delegate?.goToPropertiesList(from: list)
    }
    
    @IBAction func sharesButtonPressed(_ sender: Any) {
        guard let list = self.ownedList else { return }
        delegate?.goToSharesList(from: list)
    }
    
}
