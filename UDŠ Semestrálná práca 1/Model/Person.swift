//
//  Person.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

// MARK: - Osoba

public class Person {
    
    private let _id: String // Rodne cislo - unikatne - 16 znakove
    private let _firstName: String
    private let _lastName: String
    private let _dateOfBirth: Int
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    private var _home: Property
    private var _ownedLists: AVLTree<OwnedList>
    
    init(id: String, firstName: String, lastName: String, dateOfBirth: Int, home: Property) {
        self._id = id
        self._firstName = firstName
        self._lastName = lastName
        self._dateOfBirth = dateOfBirth
        self._home = home
        self._ownedLists = AVLTree<OwnedList>(OwnedList.comparator)
    }
    
    var id: String {
        get {
            return self._id
        }
    }
    
    var firstName: String {
        get {
            return self._firstName
        }
    }
    
    var lastName: String {
        get {
            return self._lastName
        }
    }
    
    var dateOfBirth: Int {
        get {
            return self._dateOfBirth
        }
    }
    
    var home: Property {
        get {
            return self._home
        }
    }
    
    var ownedLists: AVLTree<OwnedList> {
        get {
            return self._ownedLists
        }
    }
    
    static func random(property: Property) -> Person {
        return Person(
            id: DataSeeder.personPersonalID(),
            firstName: DataSeeder.personName(),
            lastName: DataSeeder.personLastName(),
            dateOfBirth: DataSeeder.personRandomDateOfBirth(),
            home: property)
    }
    
}

// MARK: - Public

extension Person {
    
    func setHome(property: Property) {
        self._home = property
    }
    
    func addOwnedList(ownedList: OwnedList) -> Bool {
        return self._ownedLists.insert(ownedList)
    }
    
}

// MARK: - Custom comparator

extension Person {
    
    static let comparator: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Person, let p2 = rhs as? Person else { return ComparisonResult.orderedSame }
    
        if p1.id == p2.id {
            return ComparisonResult.orderedSame
        } else if p1.id < p2.id {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}

extension Person: Hashable {
    
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
}
