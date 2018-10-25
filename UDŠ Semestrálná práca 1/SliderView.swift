//
//  SliderView.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit
import Foundation

class SliderView: UIView {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var step: Float = 5
    
    @IBAction func slider(_ sender: Any) {
        let value = round(slider.value / step) * step
        slider.value = value
        count.text = "\(Int(value))"
    }
    
}
