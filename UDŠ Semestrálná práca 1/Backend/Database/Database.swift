//
//  Database.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

typealias PropertyShare = (property: Property, share: Double)

enum RegionSearchKey {
    case id(UInt)
    case name(String)
}

typealias OwnedListData = (ownedList: OwnedList, properties: [Property], shares: [Share])

public final class Database { // SINGLETON
    public static let shared = Database()
    private init() {}
    
    private var _persons = AVLTree<Person>(Person.comparator)
    private var _regionsByID = AVLTree<Region>(Region.comparatorByID)
    private var _regionsByName = AVLTree<Region>(Region.comparatorByName)
}

// MARK: - Database operations

extension Database {
    
    // MARK: - Search operations
    
    func searchPerson(personID: String, completion: (Person?) -> Void) {
        guard let person = _persons.findBy(element: Person(id: personID)) else {
            completion(nil)
            return
        }
        completion(person)
    }
    
    func searchOwnedList(key: RegionSearchKey, ownedListID: UInt) -> OwnedListData? {
        var tempRegion: Region?
        switch key {
        case .id(let id):
            tempRegion = _regionsByID.findBy(element: Region.init(regionID: id, regionName: ""))
        case .name(let name):
            tempRegion = _regionsByName.findBy(element: Region.init(regionID: 0, regionName: name))
        }
        
        guard let region = tempRegion else {
            return nil
        }
        
        guard let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownedListID, region: region)) else {
            return nil
        }
        
        return (
            ownedList: ownedList,
            properties: ownedList.properties.inOrderToArray(),
            shares: ownedList.shares.inOrderToArray()
        )
    }
    
    func searchProperty(key: RegionSearchKey, propertyID: UInt, completion: ((Property)?) -> ()) {
        var tempRegion: Region?
        switch key {
        case .id(let id):
            tempRegion = _regionsByID.findBy(element: Region.init(regionID: id, regionName: ""))
        case .name(let name):
            tempRegion = _regionsByName.findBy(element: Region.init(regionID: 0, regionName: name))
        }
        
        guard let region = tempRegion else {
            completion(nil)
            return
        }
        
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            completion(nil)
            return
        }
        
        completion(property)
    }
    
    // MARK: - Data modificators
    
    func addPerson(personalID: String, name: String, surname: String, dateOfBirth: Int) -> Bool {
        return _persons.insert(Person(id: personalID, firstName: name, lastName: surname, dateOfBirth: dateOfBirth))
    }
    
    func addRegion(name: String) -> Bool {
        let regionID: UInt = UInt(_regionsByID.count + 1)
        let region = Region(regionID: regionID, regionName: name)
    
        if _regionsByName.insert(region) {
            _regionsByID.insert(region)
            return true
        }
        return false
    }
    
    func addProperty(regionID: UInt, ownerListID: UInt, address: String, desc: String) -> Bool {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: ""))
            , let ownerList = region.ownedLists.findBy(element: OwnedList(id: ownerListID, region: region)) else {
                return false
        }
        
        // TODO: Property ID custom form
        let property = Property(id: DataSeeder.propertyID(), address: address, desc: desc, ownedList: ownerList)
        return ownerList.addProperty(property: property) && region.addProperty(property: property)
    }
    
    func addNewOwnerList(ownerListID: UInt, for region: Region) -> Bool {
        return region.addOwnedList(list: OwnedList(id: ownerListID, region: region))
    }
    
    func getPersons(completion: ([Person]) -> ()) {
        let persons = _persons.inOrderToArray()
        completion(persons)
    }
    
    func getRegion(regionID: UInt) -> Region? {
        return _regionsByID.findBy(element: Region(regionID: regionID, regionName: ""))
    }
    
    func getRegion(regionName: String) -> Region? {
        return _regionsByName.findBy(element: Region(regionID: 0, regionName: regionName))
    }
    
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
    
    func getOwnerList(regionID: UInt, ownerListID: UInt, completion: @escaping (OwnedList?) -> ()) {
        guard let region = self._regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            completion(nil)
            return
        }
        guard let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownerListID, region: region)) else {
            completion(nil)
            return
        }
        
        completion(ownedList)
    }
    
    func getPerson(id: String) -> Person? {
        return _persons.findBy(element: Person(id: id, firstName: "", lastName: "", dateOfBirth: 0))
    }
    
    func savePersonToOwnerList(ownedList: OwnedList, person: Person) -> Bool {
        return ownedList.addNewOwner(owner: person, share: 0.0)
    }
    
    func getOwnerProperties(personalID: String, regionID: UInt, completion: @escaping ([PropertyShare]?) -> ()) {
        
        let tempPerson = Person(id: personalID, firstName: "", lastName: "", dateOfBirth: 0)
        guard let region = self._regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            completion(nil)
            return
        }
        var result = [PropertyShare]()
        region.ownedLists.inOrder() { ownedList in
            if let share = ownedList.shares.findBy(element: Share(person: tempPerson, shareCount: 0))?.shareCount {
                ownedList.properties.inOrder() { property in
                    result.append((property: property, share: share))
                }
            }
        }
        completion(result)
    }
    
    func getRegions(sortedBy type: RegionSearchKey) -> AVLTree<Region> {
        switch type {
        case .id:
            return _regionsByID
        case .name:
            return _regionsByName
        }
    }
    
    func updateSharesInOwnedList(ownedList: OwnedList, newShares: [Double]) {
        var index = 0
        if ownedList.shares.count == newShares.count {
            ownedList.nullPercentage()
            ownedList.shares.inOrder() { share in
                share.updateShareCount(value: newShares[index])
            }
            index += 1
        }
    }
    
    // MARK: - Listing
    
    func getPersonList(regionID: UInt, ownedListID: UInt, propertyID: UInt) -> [Person]? {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return nil
        }
        
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            return nil
        }
        
        if property.ownedList.id !=  ownedListID {
            return nil
        }
        
        return property.persons.inOrderToArray()
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
            
            var ownedList = OwnedList.random(region: region)
            while region.addOwnedList(list: ownedList) != true {
                ownedList = OwnedList.random(region: region)
            }
            ownedList.setRegion(region: region)
            
            var propertyArray =  [Property]()
            
            for var j in 0..<propertyCount {
                var property = Property.random(ownedList: ownedList)
                if region.addProperty(property: property) == false {
                    "WARNING - Nehnuteľnost s ID: \(property.id) nebola pridaná z dôvodu duplicity ID".debugMessage()
                    j -= 1
                    property = Property.random(ownedList: ownedList)
                    continue
                }
                "Nehnuteľnost s ID: \(property.id) bola úspešne pridaná".debugMessage()
                
                
                if Int.random(in: 0...100) < 30 { // 30 percent chance, that property appiear in new ownerList
                    ownedList = OwnedList.random(region: region)
                    while region.addOwnedList(list: ownedList) != true {
                        ownedList = OwnedList.random(region: region)
                    }
                    ownedList.setRegion(region: region)
                }
                
                if ownedList.addProperty(property: property) {
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
                        property.ownedList.addNewOwner(owner: person, share: Double.random(in: 0.0...1.0))
                    }
                    
                    propertyIndex += 1
                }
                
            }
        }
        
        completion()
    }
    
}
