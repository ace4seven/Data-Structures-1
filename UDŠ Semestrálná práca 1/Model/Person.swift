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
    
    let id: String // Rodne cislo - unikatne - 16 znakove
    
    let firstName: String
    let lastName: String
    let dateOfBirth: Int
    
    var permanentProperty: Property?
    
    public static func random(property: Property? = nil) -> Person {
        return Person(
            id: DataSeeder.personPersonalID(),
            firstName: DataSeeder.personName(),
            lastName: DataSeeder.personLastName(),
            dateOfBirth: DataSeeder.personRandomDateOfBirth(),
            permanentProperty: property)
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
