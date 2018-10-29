//
//  ControlPersonListViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum ControlPersonType {
    case all([Person])
    case propertyPersons(Property)
    case ownedListPersons(OwnedList)
}

protocol ControlPersonListVM: ControlPersonCellDelegate {
    func setup(viewDelegate: ControlPersonViewDelegate)
}

protocol ControlPersonViewDelegate: class {
    func showPropertyHeader(property: Property)
    func showPersons(persons: [Person])
    func goToPersonOwnedLists(person: Person)
    
    func showOwnedListHeader(ownedList: OwnedList)
    func showSharePersons(shares: [Share])
}
