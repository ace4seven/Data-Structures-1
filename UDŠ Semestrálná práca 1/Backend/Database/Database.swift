//
//  Database.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum RegionTreeType {
    case sortedByID
    case sortedByName
}

public final class Database { // SINGLETON
    public static let shared = Database()
    private init() {}
    
    private var _persons = AVLTree<Person>(Person.comparator)
    private var _regionsByID = AVLTree<Region>(Region.comparatorByID)
    private var _regionsByName = AVLTree<Region>(Region.comparatorByName)
}

// MARK: - Database operations

extension Database {
    
    func getRegions(sortedBy type: RegionTreeType) -> AVLTree<Region> {
        switch type {
        case .sortedByID:
            return _regionsByID
        case .sortedByName:
            return _regionsByName
        }
    }
    
}

// DATA GENERATION

extension Database {
    
    public func generateRegion(count: Int, completion: () -> ()) {
        var index = count
    
        while index > 0 {
            let region = Region.random()
            if _regionsByID.insert(region) {
                if _regionsByName.insert(region) {
                    index -= 1
                } else {
                    _regionsByID.remove(region)
                    continue
                }
            }
        }
        
        completion()
    }
    
    public func generateProperty(count: Int, completion: () -> ()) {
        _regionsByID.inOrder() { next in
            var region = next
            var propertyTree = AVLTree<Property>(Property.comparator)
            
            var index = count
            
            while index > 0 {
                if propertyTree.insert(Property.random()) {
                    index -= 1
                }
            }
            region.properties = propertyTree
        }
        
        completion()
    }
    
}
