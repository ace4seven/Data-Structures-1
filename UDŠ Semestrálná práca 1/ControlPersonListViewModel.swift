//
//  ControlPersonListViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

final class ControlPersonListViewModel {
    
    fileprivate weak var viewDelegate: ControlPersonViewDelegate?
    fileprivate let type: ControlPersonType
    
    init(type: ControlPersonType) {
        self.type = type
    }
}

extension ControlPersonListViewModel: ControlPersonListVM {
    
    func goToOwnedList(for person: Person) {
        viewDelegate?.goToPersonOwnedLists(person: person)
    }
    
    func setup(viewDelegate: ControlPersonViewDelegate) {
        self.viewDelegate = viewDelegate
        
        switch type {
        case .all(let persons):
            viewDelegate.showPersons(persons: persons)
        case .propertyPersons(let property):
            viewDelegate.showPropertyHeader(property: property)
            viewDelegate.showPersons(persons: property.persons.inOrderToArray())
        case .ownedListPersons(let ownedList):
            viewDelegate.showOwnedListHeader(ownedList: ownedList)
            viewDelegate.showSharePersons(shares: ownedList.shares.inOrderToArray())
        }
    }
    
}
