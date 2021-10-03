//
//  ListViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum ListType {
    case property(Property)
    case propertyWithShare(PropertyShare)
    case region(Region)
    case person(Person)
}

protocol ListVM: class {
    func setup(viewDelegate: ListViewDelegate)
}

protocol ListViewDelegate: class {
    func showData(items: [ListType])
}
