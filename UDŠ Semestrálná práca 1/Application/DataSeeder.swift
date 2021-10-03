//
//  DataSeeder.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

// TODO: Zmenit generator na jednoduchsie cisla

class DataSeeder {
    
    public static var regionCount: UInt = 0
    public static var propertyCount: UInt = 0
    public static var ownedListCount: UInt = 0
    public static var personIDCount: UInt = 1111111111111111
    
    // MARK: - Person model seeder
    
    public static func personName() -> String {
        return NameStorage.firstNames[Int.random(in: 0..<NameStorage.firstNames.count)]
    }
    
    public static func personLastName() -> String {
        return NameStorage.lastNames[Int.random(in: 0..<NameStorage.lastNames.count)]
    }
    
    // Random unix timestamp from 1950 to 2000
    public static func personRandomDateOfBirth() -> Int {
        return Int.random(in: -631152000...978134400)
    }
    
    public static func personPersonalID() -> String {
//        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        var result = ""
//
//        var addedLetters = 0
//
//        while addedLetters < 16 {
//            let rand = arc4random_uniform(UInt32(letters.length))
//            var nextChar = letters.character(at: Int(rand))
//            result += NSString(characters: &nextChar, length: 1) as String
//            addedLetters += 1
//        }
        let result = personIDCount
        personIDCount += 1
        
        return "\(result)"
    }
    
    // MARK: - Region model seeder
    
    public static func regionRegionID() -> UInt {
        DataSeeder.regionCount += 1
        return DataSeeder.regionCount
    }
    
    public static func regionRegionName() -> String {
        let wordsCount = Int.random(in: 1...3)
        var result = ""
        
        var firstCapitalized = false
        for i in 0..<wordsCount {
            let word = RegionNamesStorage.names[Int.random(in: 0..<RegionNamesStorage.names.count)]
            result += !firstCapitalized ? word.capitalized : word
            
            firstCapitalized = true
            if i < wordsCount - 1 {
                result += " "
            }
        }
        
        return result
    }
    
    // MARK: - Property model seeder
    
    public static func propertyID() -> UInt {
        DataSeeder.propertyCount += 1
        return DataSeeder.propertyCount
    }
    
    public static func propertyAddress() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let postFix = "Africa"
        let randomCount = Int.random(in: 5...15)
        
        let randomAddressNumber = Int.random(in: 10...999)
        
        var randomString = ""
        
        for _ in 0..<randomCount {
            let rand = arc4random_uniform(UInt32(letters.length))
            var nextChar = letters.character(at: Int(rand))
            let stringChar = NSString(characters: &nextChar, length: 1) as String
            randomString += randomString.trimmingCharacters(in: .whitespaces) == "" ? stringChar.capitalized : stringChar
        }
        
        return randomString + " " + "\(randomAddressNumber)" + " " + postFix
    }
    
    public static func propertyDesc() -> String {
        let wordsCount = Int.random(in: 10...60)
        var result = ""
        
        var firstCapitalized = false
        for i in 0..<wordsCount {
            let word = PropertyDescStorage.words[Int.random(in: 0..<PropertyDescStorage.words.count)]
            result += !firstCapitalized ? word.capitalized : word
            
            firstCapitalized = true
            if i < wordsCount - 1 {
                result += " "
            }
        }
        
        return result
    }
    
    // MARK: - OwnedList model seeder
    
    public static func ownedListID() -> UInt {
        DataSeeder.ownedListCount += 1
        return DataSeeder.ownedListCount
    }
    
}
