//
//  ControlPropertiesViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

final class ControlPropertyViewModel {
    
    fileprivate weak var viewDelegate: ControlPropertyViewDelegate?
    fileprivate let type: ControlPropertyType
    
    init(type: ControlPropertyType) {
        self.type = type
    }
    
}

extension ControlPropertyViewModel: ControlPropertyVM {
    
    func ownedListDetail(property: Property) {
        
    }
    
    func personList(property: Property) {
        viewDelegate?.goToPersonList(property: property)
    }
    
    func setup(viewDelegate: ControlPropertyViewDelegate) {
        self.viewDelegate = viewDelegate
        
        switch type {
        case .region(let region):
            viewDelegate.showRegionHeader(region: region)
            viewDelegate.showProperties(properties: region.properties.inOrderToArray())
        case .ownedList(let ownedList):
            viewDelegate.showOwnedListheader(ownedList: ownedList)
            viewDelegate.showProperties(properties: ownedList.properties.inOrderToArray())
        }
    }
    
}
