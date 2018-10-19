//
//  Region.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

// MARK: - Katastrálne územie

import Foundation

struct Region {
    
    let regionID: UInt
    let regionName: String
    
    var ownedLists: AVLTree<OwnedList>?
    var properties: AVLTree<Property>?
}
