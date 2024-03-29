//
//  ShareCell.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ShareCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    func setup(share: Share) {
        self.nameLabel.text = share.person.fullName
        self.shareLabel.text = "\(share.shareCount.roundString(makePercent: true)) %"
    }
    
}
