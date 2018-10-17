//
//  Generator.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public final class Generator {
    
    private var random = arc4random()
    
}

// PERSONS GENERATOR

extension Generator {
    
//    func generatePerson() -> Person {
//        let randomName = NameStorage.firstNames[Int.random(in: 0..<NameStorage.firstNames.count)]
//        let randomSurname = NameStorage.lastNames[Int.random(in: 0..<NameStorage.lastNames.count)]
//        let randomPersonID = generatePersonID()
//        let randomDateOfBirth = 4442432423423423
//        let randomProperty = Property.init(registerNumber: UInt.random(in: 1..<10000000), address: "Lorem ipsum", desc: "Lorem ipsum")
//
////        let person = Person.init(firstName: randomName, lastName: randomSurname, personID: randomPersonID, dateOfBirth: randomDateOfBirth, permanentProperty: randomProperty)
//
//        return person
//    }
    
}

// MARK: - Helpers

extension Generator {
    
    func generatePersonID() -> UInt {
        return UInt.random(in: 1000000000000000...9999999999999999)
    }
    
}
