//
//  ControlPropertiesViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum ControlPropertyType {
    case region(Region)
    case ownedList(OwnedList)
}

protocol ControlPropertyVM: ControlPropertyCellDelegate {
    func setup(viewDelegate: ControlPropertyViewDelegate)
}

protocol ControlPropertyViewDelegate: class {
    func showRegionHeader(region: Region)
    func showOwnedListheader(ownedList: OwnedList)
    func showProperties(properties: [Property])
    
    func goToPersonList(property: Property)
}
