//
//  Shares.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public class Share {
    private var _person: Person!
    private var _shareCount: Double
    
    init(person: Person, shareCount: Double) {
        self._person = person
        self._shareCount = shareCount
    }
    
    var person: Person {
        get {
            return self._person
        }
    }
    
    var shareCount: Double {
        get {
            return self._shareCount
        }
    }
    
}

extension Share {
    
    func updateShareCount(value: Double) {
        self._shareCount = value
    }
    
    func changeOwner(person: Person) {
        self._person = person
    }
    
}

// MARK: - Custom comparator

extension Share {
    
    static let comparator: Comparator = { lhs, rhs in
        guard let p1 = lhs as? Share, let p2 = rhs as? Share else { return ComparisonResult.orderedSame }
        
        if p1.person.id == p2.person.id {
            return ComparisonResult.orderedSame
        } else if p1.person.id < p2.person.id {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
        
    }
    
}

extension Share: Exportable {
    
    public func toString() -> String {
        return "\(person.id)\(C.separator)\(shareCount)\(C.newLine)"
    }
    
}



