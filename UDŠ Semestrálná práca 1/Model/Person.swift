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
    let personID: String // Datum narodenia
    let dateOfBirth: Int
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
