//
//  SearchCellTableViewCell.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var icoImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskWrapper: UIView!
    @IBOutlet weak var cellWrapper: UIView!
    
    func setupCell(option: Option) {
        setupUI()
        
        descLabel.text = option.desc
        self.taskLabel.text = "\(option.number)"
        self.icoImageView.image = option.image
    }
    
    private func setupUI() {
        cellWrapper.backgroundColor = .primary
        cellWrapper.layer.cornerRadius = 10
        taskWrapper.layer.cornerRadius = taskWrapper.frame.width / 2
        taskWrapper.layer.borderWidth = 1.0
        taskWrapper.layer.borderColor = UIColor.black.cgColor
        taskWrapper.backgroundColor = .secondary
        icoImageView.tintColor = .white
        
    
    }
    
}
