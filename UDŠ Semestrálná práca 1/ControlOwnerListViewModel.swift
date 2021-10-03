//
//  ControlOwnerListViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation



class ControlOwnerListViewModel {
    
    fileprivate weak var viewDelegate: ControlOwnerListViewDelegate?
    fileprivate let controlType: ControlOwnerType
    
    init(type: ControlOwnerType) {
        self.controlType = type
    }
    
}

extension ControlOwnerListViewModel: ControlOwnerListVM {
    
    func goToPropertiesList(from ownerList: OwnedList) {
        viewDelegate?.goToProperties(ownedList: ownerList)
    }
    
    func goToSharesList(from ownerList: OwnedList) {
        viewDelegate?.gotoPersons(ownedList: ownerList)
    }
    
    
    func setup(viewDelegate: ControlOwnerListViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showHeader(for: controlType)
        
        switch controlType {
        case .person(let person):
            viewDelegate.showOwnerLists(items: person.ownedLists.inOrderToArray())
        case .region(let region):
            viewDelegate.showOwnerLists(items: region.ownedLists.inOrderToArray())
        }
    }
    
}
