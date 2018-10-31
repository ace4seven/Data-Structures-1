//
//  Region.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

// MARK: - Katastrálne územie

import Foundation

public class Region {
    
    fileprivate let _regionID: UInt
    fileprivate let _regionName: String
    
    private var _ownedLists: AVLTree<OwnedList>!
    private var _properties: AVLTree<Property>!
    
    init(regionID: UInt, regionName: String) {
        self._regionID = regionID
        self._regionName = regionName
        
        self._properties = AVLTree<Property>(Property.comparator)
        self._ownedLists = AVLTree<OwnedList>(OwnedList.comparator)
    }
    
//    deinit {
//        self._ownedLists = nil
//        self._properties = nil
//    }
    
    static func random(
        properties: AVLTree<Property>? = nil
        ) -> Region {
        return Region(regionID: DataSeeder.regionRegionID(),
                      regionName: DataSeeder.regionRegionName())
    }
    
    var regionID: UInt {
        get {
            return self._regionID
        }
    }
    
    var regionName: String {
        get {
            return self._regionName
        }
    }
    
    var ownedLists: AVLTree<OwnedList> {
        get {
            return self._ownedLists
        }
    }
    
    var properties: AVLTree<Property> {
        get {
            return self._properties
        }
    }
    
}

// MARK: - Public

extension Region {
    
    @discardableResult
    func addProperty(property: Property) -> Bool {
        return _properties.insert(property)
    }
    
    @discardableResult
    func addOwnedList(list: OwnedList) -> Bool {
        return _ownedLists.insert(list)
    }
    
}

// MARK: - Comparators

extension Region {
    
    static let comparatorByID: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Region, let p2 = rhs as? Region else { return ComparisonResult.orderedSame }
        
        if p1._regionID == p2._regionID {
            return ComparisonResult.orderedSame
        } else if p1._regionID < p2._regionID {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
    static let comparatorByName: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Region, let p2 = rhs as? Region else { return ComparisonResult.orderedSame }
        
        if p1._regionName == p2._regionName {
            return ComparisonResult.orderedSame
        } else if p1._regionName < p2._regionName {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}

// MARK: - Exportable

extension Region: Exportable {
    
    public func toString() -> String {
          return "\(_regionID)\(C.separator)\(_regionName) \(C.newLine)"
    }
    
}
