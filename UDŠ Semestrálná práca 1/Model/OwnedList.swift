//
//  OwnedList.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

struct OwnedList {
    
    let id: UInt
    let region: Region
    
    var properties: AVLTree<Property>?
    
    public static func random(region: Region, properties: AVLTree<Property>? = nil) -> OwnedList {
        return OwnedList(id: DataSeeder.ownedListID(),
                         region: region,
                         properties: properties)
    }
    
}

// MARK: - Custom comparator

extension OwnedList {
    
    static let comparator: Comparator = { lhs, rhs in
        guard let p1 = lhs as? OwnedList, let p2 = rhs as? OwnedList else { return ComparisonResult.orderedSame }
        
        if p1.id == p2.id {
            return ComparisonResult.orderedSame
        } else if p1.id < p2.id {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}
