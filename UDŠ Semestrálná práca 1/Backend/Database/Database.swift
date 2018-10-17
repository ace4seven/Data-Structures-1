//
//  Database.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public final class Database { // SINGLETON
    public static let shared = Database()
    private init() {}
    
//    internal var persons = AVLTree<Person>()
    
    private let generator = Generator()
}

extension Database {
    
    func addPerson(person: Person) {
//        self.persons.insert(person)
    }
    
}

// DATA GENERATION

extension Database {
    
    func generatePersons(count: Int) {
        for _ in 0..<count {
//            addPerson(person: generator.generatePerson())
        }
    }
    
}
