//
//  Property.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

struct Property {
    
    let id: UInt
    let address: String
    let desc: String
    
    var persons: AVLTree<Person>?
    
}
