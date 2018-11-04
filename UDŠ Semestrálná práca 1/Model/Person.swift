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
    private var _home: Property?
    private var _ownedLists: AVLTree<OwnedList>!
    
    init(id: String, firstName: String, lastName: String, dateOfBirth: Int) {
        self._id = id
        self._firstName = firstName
        self._lastName = lastName
        self._dateOfBirth = dateOfBirth
        self._ownedLists = AVLTree<OwnedList>(OwnedList.comparatorComposite)
    }
    
    init(id: String) {
        self._id = id
        self._firstName = ""
        self._lastName = ""
        self._dateOfBirth = 0
        self._ownedLists = AVLTree<OwnedList>(OwnedList.comparatorComposite)
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
    
    var dateOfBirth: Date {
        get {
            return Date(timeIntervalSince1970: TimeInterval(self._dateOfBirth))
        }
    }
    
    var home: Property? {
        get {
            return self._home
        }
    }
    
    var ownedLists: AVLTree<OwnedList> {
        get {
            return self._ownedLists
        }
    }
    
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    static func random() -> Person {
        return Person(
            id: DataSeeder.personPersonalID(),
            firstName: DataSeeder.personName(),
            lastName: DataSeeder.personLastName(),
            dateOfBirth: DataSeeder.personRandomDateOfBirth())
    }
    
}

// MARK: - Public


extension Person {
    
    func setHome(property: Property) {
        self._home = property
    }
    
    @discardableResult
    func addOwnedList(ownedList: OwnedList) -> Bool {
        return self._ownedLists.insert(ownedList)
    }
    
    @discardableResult
    func removeOwnedList(ownedList: OwnedList) -> OwnedList? {
        return self._ownedLists.remove(ownedList)
    }
    
    func removeHome() {
        self._home = nil
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


extension Person: Exportable {
    
    public func toString() -> String {
        return "\(_id)\(C.separator)\(_firstName)\(C.separator)\(_lastName)\(C.separator)\(_dateOfBirth)\(C.newLine)"
    }
    
}
