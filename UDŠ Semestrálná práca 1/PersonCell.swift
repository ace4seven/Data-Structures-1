//
//  PersonCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    
    
    func setupCell(person: Person) {
        setupUI()
        
        nameLabel.text = "\(person.fullName) - \(person.id)"
        print(person.id)
        dateOfBirthLabel.text = Formatters.dateToString(date: person.dateOfBirth)
    }
    
    private func setupUI() {
        self.icoImageView.tintColor = .primary
        nameLabel.textColor = .primary
    }
    
}
