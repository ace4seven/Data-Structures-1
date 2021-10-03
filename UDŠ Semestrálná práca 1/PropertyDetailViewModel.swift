//
//  PropertyDetailViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class PropertyDetailViewModel {
    
    fileprivate weak var viewDelegate: PropertyDetailViewDelegate?
    fileprivate let property: Property
    
    init(property: Property) {
        self.property = property
    }
    
}

extension PropertyDetailViewModel: PropertyDetailVM {
    
    func setup(viewDelegate: PropertyDetailViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showProperty(property: self.property)
    }
    
}
