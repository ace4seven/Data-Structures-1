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
    
    private var _persons = AVLTree<Person>(Person.comparator)
    private var _regionsByID = AVLTree<Region>(Region.comparatorByID)
    private var _regionsByName = AVLTree<Region>(Region.comparatorByName)
}

// MARK: - Database operations

extension Database {
    
    func addPerson(person: Person) {
//        self.persons.insert(person)
    }
    
}

// DATA GENERATION

extension Database {
    
    public func generateRegion(count: Int) {
        var index = count
    
        while count > 0 {
            let region = Region.random()
            if _regionsByID.insert(region) {
                if _regionsByName.insert(region) {
                    index -= 1
                } else {
                    _regionsByID.remove(region)
                    continue
                }
            }
        }
    }
    
    public func generateProperty(count: Int) {
        
    }
    
}
