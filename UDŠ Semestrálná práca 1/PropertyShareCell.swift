//
//  PropertyShareCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PropertyShareCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    
    
    func setupCell(propertyShare: PropertyShare) {
        setupUI()
        
        idLabel.text = "\(propertyShare.property.id)"
        descLabel.text = propertyShare.property.desc
        addressLabel.text = propertyShare.property.address
        self.shareLabel.text = "Podiel: \(propertyShare.share.roundString(makePercent: true)) %"
    }
    
    private func setupUI() {
        self.icoImageView.tintColor = .primary
        idLabel.textColor = .primary
    }
    
}
