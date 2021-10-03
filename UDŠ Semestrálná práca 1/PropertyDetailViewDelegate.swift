//
//  PropertyDetailViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol PropertyDetailVM: class {
    func setup(viewDelegate: PropertyDetailViewDelegate)
}

protocol PropertyDetailViewDelegate: class {
    
    func showProperty(property: Property)
    
}
