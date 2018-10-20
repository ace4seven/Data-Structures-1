//
//  Region.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

// MARK: - Katastrálne územie

import Foundation

public struct Region {
    
    let regionID: UInt
    let regionName: String
    
    var ownedLists: AVLTree<OwnedList>?
    var properties: AVLTree<Property>?
    
    static func random(
        ownedLists: AVLTree<OwnedList>? = nil,
        properties: AVLTree<Property>? = nil
        ) -> Region {
        return Region(regionID: DataSeeder.regionRegionID(),
                      regionName: DataSeeder.regionRegionName(),
                      ownedLists: ownedLists,
                      properties: properties)
    }
    
}

// MARK: - Comparators

extension Region {
    
    static let comparatorByID: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Region, let p2 = rhs as? Region else { return ComparisonResult.orderedSame }
        
        if p1.regionID == p2.regionID {
            return ComparisonResult.orderedSame
        } else if p1.regionID < p2.regionID {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
    static let comparatorByName: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Region, let p2 = rhs as? Region else { return ComparisonResult.orderedSame }
        
        if p1.regionName == p2.regionName {
            return ComparisonResult.orderedSame
        } else if p1.regionName < p2.regionName {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}
