//
//  ControlPersonCell.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol ControlPersonCellDelegate: class {
    func goToOwnedList(for person: Person)
}

class ControlPersonCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var personalIDLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var ownedListCountLabel: UILabel!
    
    @IBOutlet weak var shareLabel: UILabel!
    
    
    fileprivate var person: Person?
    
    weak var delegate: ControlPersonCellDelegate?
    
    func setupCell(person: Person, share: Double? = nil) {
        self.person = person
        
        if let share = share {
            shareLabel.text = share.roundString(makePercent: true) + " %"
            shareLabel.alpha = 1.0
        } else {
            shareLabel.alpha = 0.0
        }
        
        self.personalIDLabel.text = person.id
        self.nameLabel.text = person.fullName
        
        ownedListCountLabel.text = "\(person.ownedLists.count)"
        
        if let home = person.home {
            self.homeLabel.text = "Supisne číslo: \(home.id) v K.U: \(home.ownedList.region.regionName)"
        } else {
            homeLabel.text = "Trvalé bydlisko nieje evidované"
        }
        
        
    
    }
    
    @IBAction func ownedListsButtonPressed(_ sender: Any) {
        guard let person = self.person else { return }
        
        delegate?.goToOwnedList(for: person)
    }
    

}
