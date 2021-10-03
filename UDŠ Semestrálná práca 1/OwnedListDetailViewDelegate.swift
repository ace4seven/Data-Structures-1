//
//  OwnedListDetailViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol OwnedListDetailVM: class {
    func setup(viewDelegate: OwnedListDetailViewDelegate)
}

protocol OwnedListDetailViewDelegate: class {
    func showItems(ownedList: OwnedList, properties: [Property], shares: [Share])
}
