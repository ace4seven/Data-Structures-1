//
//  PropertyCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PropertyCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    

    func setupCell(property: Property) {
        setupUI()
        
        idLabel.text = "\(property.id)"
        descLabel.text = property.desc
        addressLabel.text = property.address
    }
    
    private func setupUI() {
        self.icoImageView.tintColor = .primary
        idLabel.textColor = .primary
    }
    
}
