//
//  EditShareCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol EditShareCellDelegate {
    func editShare(value: Float, index: Int)
}

class EditShareCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personalIDLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var delegate: EditShareCellDelegate?
    
    fileprivate var index = 0
    
    func setup(share: Share, index: Int) {
        self.index = index
        self.nameLabel.text = share.person.fullName
        self.personalIDLabel.text = share.person.id
        self.slider.value = Float(share.shareCount)
        self.percentLabel.text = share.shareCount.roundString(makePercent: true)
        
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        percentLabel.text = Double(slider.value).roundString(makePercent: true)
        delegate?.editShare(value: slider.value, index: self.index)
    }
    
}
