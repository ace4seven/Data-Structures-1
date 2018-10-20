//
//  RegionCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    
    
    func setupCell(region: Region) {
        setupUI()
        
        idLabel.text = "\(region.regionID)"
        nameLabel.text = region.regionName
    }
    
    private func setupUI() {
        self.icoImageView.tintColor = .primary
        idLabel.textColor = .primary
    }
}
