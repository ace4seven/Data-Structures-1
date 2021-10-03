//
//  ControlPropertyCell.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol ControlPropertyCellDelegate: class {
    func ownedListDetail(property: Property)
    func personList(property: Property)
}

class ControlPropertyCell: UITableViewCell {

    @IBOutlet weak var propertyIDLabel: UILabel!
    @IBOutlet weak var propertyDescLabel: UILabel!
    @IBOutlet weak var ownedListIDLabel: UILabel!
    @IBOutlet weak var personsCountLabel: UILabel!
    
    weak var delegate: ControlPropertyCellDelegate?
    
    fileprivate var property: Property?
    
    func setupCell(property: Property) {
        self.property = property
        
        propertyIDLabel.text = "\(property.id)"
        propertyDescLabel.text = property.desc
        ownedListIDLabel.text = "\(property.ownedList.id)"
        personsCountLabel.text = "\(property.persons.count)"
    }
    
    @IBAction func ownedListDetailButtonPressed(_ sender: Any) {
        guard let property = self.property else { return }
        delegate?.ownedListDetail(property: property)
    }
    
    @IBAction func personsButtonPressed(_ sender: Any) {
        guard let property = self.property else { return }
        delegate?.personList(property: property)
    }
    

}
