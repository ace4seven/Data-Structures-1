//
//  ControlOwnerListViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum ControlOwnerType {
    
    case region(Region)
    case person(Person)
    
}

protocol ControlOwnerListVM: ControlOwnerCellDelegate {
    func setup(viewDelegate: ControlOwnerListViewDelegate)
}

protocol ControlOwnerListViewDelegate: class {
    func showHeader(for type: ControlOwnerType)
    func showOwnerLists(items: [OwnedList])
    
    func gotoPersons(ownedList: OwnedList)
    func goToProperties(ownedList: OwnedList)
}
