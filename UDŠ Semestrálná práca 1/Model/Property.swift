//
//  Property.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public class Property {
    
    private var _id: UInt
    private let _address: String
    private let _desc: String
    
    private var _ownedList: OwnedList!
    private var _persons: AVLTree<Person>!
    
    init(id: UInt, address: String, desc: String, ownedList: OwnedList) {
        self._id = id
        self._address = address
        self._desc = desc
        self._ownedList = ownedList
        self._persons = AVLTree<Person>(Person.comparator)
    }
    
    init(id: UInt) {
        self._id = id
        self._address = ""
        self._desc = ""
        self._ownedList = OwnedList(id: 0, region: Region(regionID: 0, regionName: ""))
        self._persons = AVLTree<Person>(Person.comparator)
    }
    
//    deinit {
//        self._ownedList = nil
//        self._persons = nil
//    }
    
    static func random(persons: AVLTree<Person>? = nil, id: UInt? = nil, ownedList: OwnedList) -> Property {
        return Property(id: id ?? DataSeeder.propertyID(),
                        address: DataSeeder.propertyAddress(),
                        desc: DataSeeder.propertyDesc(),
                        ownedList: ownedList)
    }
    
    var id: UInt {
        get {
            return self._id
        }
    }
    
    var address: String {
        get {
            return self._address
        }
    }
    
    var desc: String {
        get {
            return self._desc
        }
    }
    
    var ownedList: OwnedList {
        get {
            return self._ownedList
        }
    }
    
    var persons: AVLTree<Person> {
        get {
            return self._persons
        }
    }
    
}

// MARK: - Public

extension Property {
    
    @discardableResult
    func addPerson(person: Person) -> Bool {
        return self._persons.insert(person)
    }
    
    func changeOwnerList(ownerList: OwnedList) {
        self._ownedList = ownerList
    }
    
    func changeID(newID: UInt) {
        self._id = newID
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

extension Property: Exportable {
    
    public func toString() -> String {
        let personsID: String = self._persons.levelOrderToArray().map{ $0.id }.joined(separator: "-")
        if personsID.trimmingCharacters(in: .whitespaces) == "" {
            return "\(_id)\(C.separator)\(_address)\(C.separator)\(_desc)\(C.newLine)"
        }
        return "\(_id)\(C.separator)\(_address)\(C.separator)\(_desc)\(C.separator)\(personsID)\(C.newLine)"
    }
    
}
