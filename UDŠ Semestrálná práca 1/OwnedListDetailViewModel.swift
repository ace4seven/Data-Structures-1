//
//  OwnedListDetailViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class OwnedListDetailViewModel {
    
    fileprivate weak var viewDelegate: OwnedListDetailViewDelegate?
    fileprivate let ownedList: OwnedList
    fileprivate let properties: [Property]
    fileprivate let shares: [Share]
    
    init(ownedList: OwnedList, properties: [Property], shares: [Share]) {
        self.ownedList = ownedList
        self.properties = properties
        self.shares = shares
    }
    
}

extension OwnedListDetailViewModel: OwnedListDetailVM {
    
    func setup(viewDelegate: OwnedListDetailViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showItems(ownedList: ownedList, properties: properties, shares: shares)
    }
    
}
