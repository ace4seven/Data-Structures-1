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
    
    func getProperties(regionName: String, completion: @escaping ([Property]?) -> ()) {
        if let region = _regionsByName.findBy(element: Region(regionID: 0, regionName: regionName)) {
            let properties = region.properties.inOrderToArray()
            completion(properties)
            return
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
    
    public func generateDatabase(regionCount: Int, propertyCount: Int, persons: Int ,completion: () -> ()) {
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
            
            var ownedList = OwnedList.random()
            while region.addOwnedList(list: ownedList) != true {
                ownedList = OwnedList.random()
            }
            ownedList.setRegion(region: region)
            
            var propertyArray =  [Property]()
            
            for var j in 0..<propertyCount {
                var property = Property.random()
                if region.addProperty(property: property) == false {
                    "WARNING - Nehnuteľnost s ID: \(property.id) nebola pridaná z dôvodu duplicity ID".debugMessage()
                    j -= 1
                    property = Property.random()
                    continue
                }
                "Nehnuteľnost s ID: \(property.id) bola úspešne pridaná".debugMessage()
                
                
                if Int.random(in: 0...100) < 30 { // 30 percent chance, that property appiear in new ownerList
                    ownedList = OwnedList.random()
                    while region.addOwnedList(list: ownedList) != true {
                        ownedList = OwnedList.random()
                    }
                    ownedList.setRegion(region: region)
                }
                
                if ownedList.addProperty(property: property) {
                    property.addOwnedList(ownedList: ownedList)
                }
                propertyArray.append(property)
            }
            
            for _ in 0..<persons {
                let person = Person.random()
                _persons.insert(person)
                var personPropertySet = false
                
                var propertyIndex = 0
                for property in propertyArray {
                    if !personPropertySet {
                        if Int.random(in: 1...100) < 20 || (propertyIndex == propertyArray.count - 1) {
                            if property.addPerson(person: person) {
                                person.setHome(property: property)
                                personPropertySet = true
                            }
                        }
                    }
                    
                    if Int.random(in: 1...1000) < 20 {
                        property.addPerson(person: person)
                    }
                    
                    if Int.random(in: 1...1000) < 10 {
                        if property.ownedList.addNewOwner(owner: person, share: Double.random(in: 0.0...1.0)) {
                            person.addOwnedList(ownedList: property.ownedList)
                        }
                    }
                    
                    propertyIndex += 1
                }
                
            }
        }
    
        completion()
    }
    
}
