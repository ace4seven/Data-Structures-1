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
    
    func getRegionsSortedByName(completion: ([Region]) -> ()){
        let regions = _regionsByName.inOrderToArray()
        completion(regions)
    }
    
    func getProperties(regionName: String, completion: ([Property]?) -> ()) {
        if let region = _regionsByName.findBy(element: Region(regionID: 0, regionName: regionName)) {
            let properties = region.properties?.inOrderToArray()
            completion(properties)
        }
        completion(nil)
    }
    
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
    
    public func generateDatabase(regionCount: Int, propertyCount: Int, completion: () -> ()) {
        for var i in 0..<regionCount {
            let region = Region.random()
            if _regionsByID.insert(region) {
                if !_regionsByName.insert(region) {
                    i -= 1
                    "WARNING - Region podla NAME: \(region.regionName) bol vymazaný z dôvodu duplicity".debugMessage()
                    _regionsByID.remove(region)
                    continue
                }
            } else {
                "WARNING - Region podla ID: \(region.regionID) bol vymazaný z dôvodu duplicity".debugMessage()
                i -= 1
                continue
            }
            "Katastrálne územie MENO: \(region.regionName) ID: \(region.regionID) bolo úspešné pridané".debugMessage()
            
            var propertyTree = AVLTree<Property>(Property.comparator)
            for var j in 0..<propertyCount {
                let property = Property.random()
                if !propertyTree.insert(property) {
                    "WARNING - Nehnuteľnost s ID: \(property.id) nebola pridaná z dôvodu duplicity ID".debugMessage()
                    j -= 1
                    continue
                }
                "Nehnuteľnost s ID: \(property.id) bola úspešne pridaná".debugMessage()
            }
            region.properties = propertyTree
        }
    }
    
}
