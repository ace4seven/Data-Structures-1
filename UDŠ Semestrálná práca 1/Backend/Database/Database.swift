//
//  Database.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

typealias PropertyShare = (property: Property, share: Float)

enum RegionSearchKey {
    case id(UInt)
    case name(String)
}

enum SortKey {
    case id
    case name
}

typealias OwnedListData = (ownedList: OwnedList, properties: [Property], shares: [Share])

public final class Database { // SINGLETON
    public static let shared = Database()
    private init() {
        self.migration = ImportExport()
    }
    
    private var _persons: AVLTree<Person>! = AVLTree<Person>(Person.comparator)
    private var _regionsByID: AVLTree<Region>! = AVLTree<Region>(Region.comparatorByID)
    private var _regionsByName: AVLTree<Region>! = AVLTree<Region>(Region.comparatorByName)
    
    fileprivate let migration: ImportExport
}

// MARK: - Database operations

extension Database {
    
    // MARK: - Search operations
    
    // MARK: - TASK 1, 5
    
    func searchProperty(key: RegionSearchKey, propertyID: UInt, completion: ((Property)?) -> ()) {
        var tempRegion: Region?
        
        // LOG(n)
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
        
        // LOG(m)
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            completion(nil)
            return
        }
        
        completion(property)
    }
    
    // MARK: - TASK 2
    
    func searchPerson(personID: String, completion: (Person?) -> Void) {
        // LOG(n)
        guard let person = _persons.findBy(element: Person(id: personID)) else {
            completion(nil)
            return
        }
        completion(person)
    }
    
    // MARK: - TASK 4 6
    
    func searchOwnedList(key: RegionSearchKey, ownedListID: UInt) -> OwnedListData? {
        var tempRegion: Region?
        switch key {
        case .id(let id):
            tempRegion = _regionsByID.findBy(element: Region.init(regionID: id, regionName: ""))
        case .name(let name):
            tempRegion = _regionsByName.findBy(element: Region.init(regionID: 0, regionName: name))
        } // O(log(n))
        
        guard let region = tempRegion else {
            return nil
        }
        
        guard let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownedListID, region: region)) else {
            return nil
        } // O(log(m))
        
        return (
            ownedList: ownedList,
            properties: ownedList.properties.inOrderToArray(), // O(K)
            shares: ownedList.shares.inOrderToArray() // O(S)
        )
    }
    
    // MARK: - Data modificators
    
    // MARK: - TASK 10
    
    func changeAddHome(for personID: String, regionName: String, propertyID: UInt) -> Person? {
        guard let person = _persons.findBy(element: Person(id: personID)) else {
            return nil
        }
        
        guard let region = _regionsByName.findBy(element: Region(regionID: 0, regionName: regionName)) else {
            return nil
        }
        
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            return nil
        }
        
        person.setHome(property: property)
        return person
    }
    
    // MARK: - TASK 16
    
    func addPerson(personalID: String, name: String, surname: String, dateOfBirth: Int) -> Bool {
        return _persons.insert(Person(id: personalID, firstName: name, lastName: surname, dateOfBirth: dateOfBirth))
    }
    
    // MARK: - TASK 22
    
    func addRegion(name: String) -> Bool {
        let regionID: UInt = UInt(_regionsByID.count + 1)
        let region = Region(regionID: regionID, regionName: name)
    
        if _regionsByName.insert(region) {
            _regionsByID.insert(region)
            return true
        }
        return false
    }
    
    func addProperty(regionID: UInt, ownerListID: UInt, propertyID: UInt, address: String, desc: String) -> Bool {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: ""))
            , let ownerList = region.ownedLists.findBy(element: OwnedList(id: ownerListID, region: region)) else {
                return false
        }
        
        let property = Property(id:propertyID, address: address, desc: desc, ownedList: ownerList)
        return ownerList.addProperty(property: property) && region.addProperty(property: property)
    }
    
    // MARK: - TASK 17
    
    func addNewOwnerList(ownerListID: UInt, for region: Region) -> Bool {
        return region.addOwnedList(list: OwnedList(id: ownerListID, region: region))
    }
    
    // MARK: - TASK 11
    
    func changePropertyOwner(oldPersonID: String, newPersonID: String, regionID: UInt, propertyID: UInt) -> Bool {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return false
        }
        
        guard let oldOwner = _persons.findBy(element: Person(id: oldPersonID)) else {
            return false
        }
        
        guard let newOwner = _persons.findBy(element: Person(id: newPersonID)) else {
            return false
        }
        
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            return false
        }
        
        let ownedList = property.ownedList
        
        if let share = ownedList.shares.findBy(element: Share(person: oldOwner, shareCount: 0)) {
            if ownedList.shares.findBy(element: Share(person: newOwner, shareCount: 0)) == nil { // New owner have not to be listed
                share.changeOwner(person: newOwner)
                oldOwner.removeOwnedList(ownedList: ownedList)
                newOwner.addOwnedList(ownedList: ownedList)
                return true
            }
        }
        
        return false
    }
    
    // MARK - TASK 19
    
    func removeOwnedList(oldOwnerListID: UInt, newOnwerListID: UInt, regionID: UInt) -> OwnedList? { // TASK 19
        
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return nil
        }
        
        guard let newOwnerList = region.ownedLists.findBy(element: OwnedList(id: newOnwerListID, region: region)) else {
            return nil
        }
        
        guard let deletedOwnerList = region.ownedLists.remove(OwnedList(id: oldOwnerListID, region: region)) else {
            return nil
        }
        
        deletedOwnerList.properties.inOrder { property in
            if !newOwnerList.addProperty(property: property) {
                print("Problem pridania nehnutelnost, dana nehnutelnost uz EXISTUJE a nemala by")
            }
        }
        
        deletedOwnerList.shares.inOrder { share in
            let incrementShare = share.shareCount + newOwnerList.percentShareSum <= 1.0
            if newOwnerList.shares.insert(incrementShare ? share : Share(person: share.person, shareCount: 0.0)) { 
                share.person.ownedLists.insert(newOwnerList)
            } else {
                if incrementShare {
                    newOwnerList.shares.findBy(element: share)?.updateShareCount(value: share.shareCount)
                    newOwnerList.increasePercentate(value: share.shareCount)
                }
            }
            newOwnerList.increasePercentate(value: incrementShare ? share.shareCount : 0.0)
            share.person.removeOwnedList(ownedList: deletedOwnerList)
        }
        
        return newOwnerList
    }
    
    // MARK: - TASK 13
    
    func deletePersonShare(personID: String, regionID: UInt, ownerListID: UInt) -> OwnedList? {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return nil
        }
        
        guard let person = _persons.findBy(element: Person(id: personID)) else {
            return nil
        }
        
        if let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownerListID, region: region)) {
            if ownedList.shares.remove(Share(person: person, shareCount: 0.0)) != nil {
                person.ownedLists.remove(ownedList)
                return ownedList
            }
        }
        
        return nil
    }
    
    // MARK: - TASK 20
    
    func deletePropertyFromOwnedList(regionID: UInt, ownedListID: UInt, propertyID: UInt) -> Property? { // TASK 20
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return nil
        }
        
        guard let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownedListID, region: region)) else {
            return nil
        }
        
        let deletedProperty = ownedList.removeProperty(property: Property(id: propertyID))
        
        deletedProperty?.persons.inOrder() { person in
            person.removeHome()
        }
        
        return deletedProperty
    }
    
    // MARK: - TASK 22
    
    func deleteRegion(deletedRegionID: UInt, movedRegionID: UInt) -> Region? { // TASK 22
        
        if deletedRegionID == movedRegionID {
            return nil
        }
        
        guard let region = _regionsByID.findBy(element: Region(regionID: movedRegionID, regionName: "")) else {
            return nil
        }
        
        guard let deletedRegion = _regionsByID.remove(Region(regionID: deletedRegionID, regionName: "")) else {
            return nil
        }
        
        _regionsByName.remove(deletedRegion)
        
        var noUniqueOwnedLists = [OwnedList]()
        var noUniqueProperties = [Property]()
        
        deletedRegion.ownedLists.inOrder() { ownedList in
            
            if !region.addOwnedList(list: ownedList) {
                noUniqueOwnedLists.append(ownedList)
            } else {
                ownedList.setRegion(region: region)
            }
            
            ownedList.properties.inOrder() { property in
                if !region.addProperty(property: property) {
                    noUniqueProperties.append(property)
                }
            }
        }
        
        for noUniqueOwnedList in noUniqueOwnedLists {
            var newID = UInt(region.ownedLists.max()?.id ?? noUniqueOwnedList.id)
            
            while region.ownedLists.findBy(element: OwnedList(id: newID, region: region)) != nil {
                newID += 1
            }
            
            noUniqueOwnedList.shares.inOrder() { share in
                share.person.ownedLists.remove(noUniqueOwnedList)
            }

            noUniqueOwnedList.setRegion(region: region)
            noUniqueOwnedList.changeID(newID: newID)

            region.addOwnedList(list: noUniqueOwnedList)
            noUniqueOwnedList.shares.inOrder() { share in
                share.person.addOwnedList(ownedList: noUniqueOwnedList)
            }
        }
        
        for noUniqueProperty in noUniqueProperties {
            var newID = UInt(region.properties.max()?.id ?? noUniqueProperty.id)
            
            while region.properties.findBy(element: Property(id: newID)) != nil {
                newID += 1
            }
            
            noUniqueProperty.ownedList.removeProperty(property: noUniqueProperty)

            noUniqueProperty.changeID(newID: newID)
            noUniqueProperty.ownedList.properties.insert(noUniqueProperty)
            region.addProperty(property: noUniqueProperty)
        }
        
        return deletedRegion
    }
    
    
    // MARK: - GET from database
    
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
    
    // MARK: - TASK 15
    
    func getRegions(key: SortKey) -> [Region] {
        switch key {
        case .id:
            return _regionsByID.inOrderToArray()
        case .name:
            return _regionsByName.inOrderToArray()
        }
    }
    
    // MARK: - TASK 7
    
    func getProperties(regionName: String, completion: @escaping ([Property]?) -> ()) {
        if let region = _regionsByName.findBy(element: Region(regionID: 0, regionName: regionName)) { // O(Log(n))
            let properties = region.properties.inOrderToArray() //(O(m))
            completion(properties)
            return
        }
        completion(nil)
    }
    
    // MARK: - TASK 12
    
    func changeShare(regionID: UInt, ownerListID: UInt, personID: String, completion: @escaping (OwnedList?) -> ()) {
        guard let region = self._regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            completion(nil)
            return
        }
        
        guard let ownedList = region.ownedLists.findBy(element: OwnedList(id: ownerListID, region: region)) else {
            completion(nil)
            return
        }
        
        guard let person = _persons.findBy(element: Person(id: personID, firstName: "", lastName: "", dateOfBirth: 0)) else {
            completion(nil)
            return
        }
        
        ownedList.addNewOwner(owner: person, share: 0.0)
        
        completion(ownedList)
    }
    
    func getAllPersons() -> [Person] {
        return _persons.inOrderToArray()
    }
    
    // MARK: - TASK 9
    
    func listOwnerProperties(personalID: String, regionID: UInt? = nil) -> [PropertyShare]? {
        guard let person = _persons.findBy(element: Person(id: personalID)) else {
            return nil
        } // O(Log(n))
        
        var result = [PropertyShare]()
        person.ownedLists.inOrder() { list in
            guard let share = list.shares.findBy(element: Share(person: person, shareCount: 0)) else {
                print("Chyba, vlastnik nema nastaveny podiel")
                return
            }
            
            list.properties.inOrder { property in
                result.append((property: property, share: share.shareCount))
            }
        }
        
        return result // O(m*Log(n*p))
    }
    
    // MARK: - Task 8
    
    func listOwnerProperties(personalID: String, regionID: UInt, completion: @escaping ([PropertyShare]?) -> ()) {
        
        let tempPerson = Person(id: personalID, firstName: "", lastName: "", dateOfBirth: 0)
        guard let region = self._regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            completion(nil)
            return
        } // O(log(n))
        var result = [PropertyShare]()
        region.ownedLists.inOrder() { ownedList in // O(m)
            if let share = ownedList.shares.findBy(element: Share(person: tempPerson, shareCount: 0))?.shareCount { // O(log(s))
                ownedList.properties.inOrder() { property in // O(p)
                    result.append((property: property, share: share))
                }
            }
        }
        completion(result) // O(m*p*log(n*s))
    }
    
    func getRegions(sortedBy type: RegionSearchKey) -> AVLTree<Region> {
        switch type {
        case .id:
            return _regionsByID
        case .name:
            return _regionsByName
        }
    }
    
    func updateSharesInOwnedList(ownedList: OwnedList, newShares: [Float]) {
        var index = 0
        if ownedList.shares.count == newShares.count {
            ownedList.nullPercentage()
            ownedList.shares.inOrder() { share in
                share.updateShareCount(value: newShares[index])
                ownedList.increasePercentate(value:  newShares[index])
            }
            index += 1
        }
    }
    
    // MARK: - Listing
    
    // MARK: - TASK 3
    
    func getPersonList(regionID: UInt, ownedListID: UInt, propertyID: UInt) -> [Person]? {
        guard let region = _regionsByID.findBy(element: Region(regionID: regionID, regionName: "")) else {
            return nil
        } // LOG(N)
        
        guard let property = region.properties.findBy(element: Property(id: propertyID)) else {
            return nil
        } // LOG(M)
        
        if property.ownedList.id != ownedListID {
            return nil
        }
        
        return property.persons.inOrderToArray() // O(K)
    }
    
}

// DATA GENERATION

extension Database {
    
    public func generateDatabase(regionsCount: Int, propertiesCount: Int, personsCount: Int, ownedListsCount: Int, maxOwnerPropertiesCount: Int, maxOwnerInListCount: Int) {
        
        var personsArray = [Person]()
        personsArray.reserveCapacity(personsCount)
        
        var regionsArray = [Region]()
        regionsArray.reserveCapacity(regionsCount)
        
        var propertiesArray = [Property]()
        propertiesArray.reserveCapacity(propertiesCount)
        
        var ownedListsArray = [OwnedList]()
        ownedListsArray.reserveCapacity(ownedListsCount)
        
        var regionIndex = 0
        while regionIndex < regionsCount {
            let region = Region.random()
            if _regionsByID.insert(region) {
                if !_regionsByName.insert(region) {
                    regionIndex -= 1
                    "WARNING - Region podla NAME: \(region.regionName) bol vymazaný z dôvodu duplicity".debugMessage()
                    _regionsByID.remove(region)
                    continue
                }
            } else {
                "WARNING - Region podla ID: \(region.regionID) bol vymazaný z dôvodu duplicity".debugMessage()
                regionIndex -= 1
                continue
            }
            
            regionsArray.append(region)
            regionIndex += 1
        }
        
        var personIndex = 0
        while personIndex < personsCount {
            let person = Person.random()
            _persons.insert(person)
            personsArray.append(person)
            personIndex += 1
        }
        
        var ownedListIndex = 0
        while ownedListIndex < ownedListsCount {
            guard let region = regionsArray.randomItem() else { break }
            let ownedList = OwnedList.random(region: region, id: UInt(region.ownedLists.count + 1), properties: nil)
            region.addOwnedList(list: ownedList)
            ownedListsArray.append(ownedList)
            ownedListIndex += 1
        }
        
        var propertiesIndex = 0
        for region in regionsArray {
            region.ownedLists.inOrder() { ownerList in
                for _ in 0..<maxOwnerPropertiesCount {
                    if propertiesIndex >= propertiesCount {
                        break
                    }
                    if Int.random(in: 0..<100) > 60 {
                        let property = Property.random(persons: nil, id: UInt(region.properties.count + 1), ownedList: ownerList)
                        region.addProperty(property: property)
                        ownerList.addProperty(property: property)
                        region.addOwnedList(list: ownerList)
                        propertiesArray.append(property)
                        propertiesIndex += 1
                    }
                }
                for _ in 0..<maxOwnerInListCount {
                    if let randomPerson = personsArray.randomItem() {
                        if ownerList.percentShareSum < 100.0 {
                            ownerList.addNewOwner(owner: randomPerson, share: Float.random(in: 0.0...1.0))
                        }
                    }
                }
            }
        }
        
        // Nastavenie trvaleho bydliska
        
        for person in personsArray {
            if let property = propertiesArray.randomItem() {
                if property.addPerson(person: person) {
                    person.setHome(property: property)
                }
            }
        }
        
    }
    
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
                        property.ownedList.addNewOwner(owner: person, share: Float.random(in: 0.0...1.0))
                    }
                    
                    propertyIndex += 1
                }
                
            }
        }
        
        completion()
    }
    
}

extension Database {
    
    func exportData(completion: @escaping () -> ()) {
        migration.prepareForExport()
        
        migration.write(headerType: .persons(count: _persons.count))
        _persons.levelOrder() { [weak self] person in
            self?.migration.write(line: person.toString())

        }
        
        _regionsByID.levelOrder() { [weak self] region in
            migration.write(headerType: .regions(count: _regionsByID.count))
            migration.write(line: region.toString())
            
            // Owned lists in region
            region.ownedLists.levelOrder() { ownedList in
                self?.migration.write(headerType: .ownedLists(count: region.ownedLists.count))
                self?.migration.write(line: ownedList.toString())
            
                // Properties in owned list
                ownedList.properties.levelOrder() { property in
                    self?.migration.write(headerType: .properties(count: ownedList.properties.count))
                    self?.migration.write(line: property.toString())
                }
                
                // Shares in owned lists
                ownedList.shares.levelOrder() { share in
                    self?.migration.write(headerType: .shares(count: ownedList.shares.count))
                    self?.migration.write(line: share.toString())
                }
            }
        }
        completion()
    }
    
    func importData(completion: @escaping () -> ()) {
        migration.prepareForImport()
        
        var personSaving = false
        var regionsSaving = false
        var ownedListSaving = false
        var propertySaving = false
        var shareSaving = false
        
        var region: Region!
        var ownedList: OwnedList!
        
        var skip = false
        
        migration.readCSV { [weak self] component in
            if let component = component {
                
                if component[0] == "SHARES" {
                    personSaving = false
                    regionsSaving = false
                    ownedListSaving = false
                    propertySaving = false
                    shareSaving = true
                    skip = true
                }
                
                if component[0] == "PROPERTIES" {
                    personSaving = false
                    regionsSaving = false
                    ownedListSaving = false
                    propertySaving = true
                    shareSaving = false
                    
                    skip = true
                }
                
                if component[0] == "OWNEDLISTS" {
                    personSaving = false
                    regionsSaving = false
                    ownedListSaving = true
                    propertySaving = false
                    shareSaving = false
                    skip = true
                }
                
                if component[0] == "REGIONS" {
                    personSaving = false
                    regionsSaving = true
                    ownedListSaving = false
                    propertySaving = false
                    shareSaving = false
                    skip = true
                }
                
                if component[0] == "PERSONS" {
                    personSaving = true
                    regionsSaving = false
                    ownedListSaving = false
                    propertySaving = false
                    shareSaving = false
                    skip = true
                }
                
                if !skip {
                    if personSaving {
                        let person = Person(id: component[0], firstName: component[1], lastName: component[2], dateOfBirth: Int(component[3])!)
                        self?._persons.insert(person)
                    }
                    
                    if regionsSaving {
                        region = Region(regionID: UInt(component[0])!, regionName: component[1])
                        self?._regionsByID.insert(region)
                        self?._regionsByName.insert(region)
                    }
                    
                    if ownedListSaving {
                        ownedList = OwnedList(id: UInt(component[0])!, region: region)
                        region.ownedLists.insert(ownedList)
                    }
                    
                    if propertySaving {
                        let property = Property(id: UInt(component[0])!, address: component[1], desc: component[2], ownedList: ownedList)
                        
                        if component.indices.contains(3) {
                            let personIDs = component[3].components(separatedBy: "-")
                            for personID in personIDs {
                                let person: Person! = self?._persons.findBy(element: Person(id: personID))!
                                person.setHome(property: property)
                                property.addPerson(person: person)
                            }
                        }
            
                        ownedList.addProperty(property: property)
                        region.addProperty(property: property)
                    }
                    
                    if shareSaving {
                        let person: Person! = self?._persons.findBy(element: Person(id: component[0]))
                        ownedList.addNewOwner(owner: person, share: Float(component[1])!)
                        person.addOwnedList(ownedList: ownedList)
                    }
                } else {
                    skip = false
                }
                
            }
        }
        completion()
    }
    
}
