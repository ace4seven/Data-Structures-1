//
//  ControlRegionCell.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol ControlRegionCellDelegate: class {
    func controlRegionOwnedListButtonPressed(region: Region)
    func controlRegionPropertiesButtonPressed(region: Region)
}

class ControlRegionCell: UITableViewCell {

    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var regionIDLabel: UILabel!
    @IBOutlet weak var ownerListCountLabel: UILabel!
    @IBOutlet weak var propertiesCountLabel: UILabel!
    
    fileprivate var region: Region?
    
    weak var delegate: ControlRegionCellDelegate?
    
    func setupCell(region: Region) {
        self.regionNameLabel.text = region.regionName
        self.regionIDLabel.text = "\(region.regionID)"
        self.ownerListCountLabel.text = "\(region.ownedLists.count)"
        self.propertiesCountLabel.text = "\(region.properties.count)"
        
        self.region = region
    }
    
    @IBAction func ownedListButtonPressed(_ sender: Any) {
        guard let region = self.region else { return }
        delegate?.controlRegionOwnedListButtonPressed(region: region)
    }
    
    @IBAction func propertiesButtonPressed(_ sender: Any) {
        guard let region = self.region else { return }
        delegate?.controlRegionPropertiesButtonPressed(region: region)
    }
    
}
