//
//  Property.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public struct Property {
    
    let id: UInt
    let address: String
    let desc: String
    
    var ownedList: OwnedList?
    var persons: AVLTree<Person>?
    
    static func random(persons: AVLTree<Person>? = nil, ownedList: OwnedList? = nil) -> Property {
        return Property(id: DataSeeder.propertyID(),
                        address: DataSeeder.propertyAddress(),
                        desc: DataSeeder.propertyDesc(),
                        ownedList: ownedList,
                        persons: persons)
    }
    
}

// MARK: - Custom comparator

extension Property {
    
    static let comparator: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Property, let p2 = rhs as? Property else { return ComparisonResult.orderedSame }
        
        if p1.id == p2.id {
            return ComparisonResult.orderedSame
        } else if p1.id < p2.id {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}
