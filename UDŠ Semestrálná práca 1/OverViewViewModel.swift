//
//  OverViewViewModel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 02/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class OverViewViewModel {
    
    weak var viewDelegate: OverViewDelegate?
    
}

extension OverViewViewModel: OverViewVM {
    
    func setup(viewDelegate: OverViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
}
