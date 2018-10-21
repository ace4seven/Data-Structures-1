//
//  OwnedList.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public class OwnedList {
    
    private let _id: UInt
    
    private var _region: Region?
    private var _properties: AVLTree<Property>
    
    private var _shares: AVLTree<Share>
    private var _percentShareSum: Double = 0.0
    
    init(id: UInt, region: Region? = nil) {
        self._id = id
        self._region = region
        self._properties = AVLTree<Property>(Property.comparator)
        self._shares = AVLTree<Share>(Share.comparator)
    }
    
    static func random(region: Region? = nil, properties: AVLTree<Property>? = nil) -> OwnedList {
        return OwnedList(id: DataSeeder.ownedListID(),
                         region: region)
    }
    
    var id: UInt {
        get {
            return self._id
        }
    }
    
    var region: Region {
        get {
            return self._region! // REGIUN HAVE TO BE SET TODO: Try catch handler
        }
    }
    
    var properties: AVLTree<Property> {
        get {
            return self._properties
        }
    }
    
    var shares: AVLTree<Share> {
        get {
            return self._shares
        }
    }
    
    var percentShareSum: Double {
        get {
            return self._percentShareSum
        }
    }
    
}

// MARK: - Public

extension OwnedList {
    
    @discardableResult
    func addProperty(property: Property) -> Bool {
        return self._properties.insert(property)
    }
    
    @discardableResult
    func addNewOwner(owner: Person, share: Double) -> Bool {
        if percentShareSum + share > 1.0 {
            return false
        } else {
            if _shares.insert(Share(person: owner, shareCount: share)) {
                _percentShareSum += share
                owner.addOwnedList(ownedList: self)
                return true
            }
            return false
        }
    }
    
    @discardableResult
    func removeOwner(oldOwner: Person) -> Bool {
        if let removedOwner = _shares.remove(Share(person: oldOwner, shareCount: 0.0)) {
            _percentShareSum -= removedOwner.shareCount
            return true
        }
        
        return false
    }
    
    func setRegion(region: Region) {
        self._region = region
    }
    
    func nullPercentage() {
        self._percentShareSum = 0
    }
    
    func increasePercentate(value: Double) {
        self._percentShareSum += value
    }
    
}

// MARK: - Custom comparator

extension OwnedList {
    
    static let comparator: Comparator = { lhs, rhs in
        guard let p1 = lhs as? OwnedList, let p2 = rhs as? OwnedList else { return ComparisonResult.orderedSame }
        
        if p1.id == p2.id {
            return ComparisonResult.orderedSame
        } else if p1.id < p2.id {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}
