//
//  Person.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

// MARK: - Osoba

struct Person {
    
    let firstName: String
    let lastName: String
    let personID: String // Rodne cislo - unikatne - 16 znakove
    let dateOfBirth: Int // Datum narodenia
    let permanentProperty: Property // Trvalý pobyt
    
}

extension Person: Comparable {
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.personID < rhs.personID
    }
    
    static func > (lhs: Person, rhs: Person) -> Bool {
        return lhs.personID > rhs.personID
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.personID == rhs.personID
    }
    
}

extension Person: CustomStringConvertible {
    
    public var description: String {
        return "\(self.personID)"
    }
    
}

// MARK: - Custom comparator

extension Person {
    
    static let compareByID: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Person, let p2 = rhs as? Person else { return ComparisonResult.orderedSame }
    
        if p1.personID == p2.personID {
            return ComparisonResult.orderedSame
        } else if p1.personID < p2.personID {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}
