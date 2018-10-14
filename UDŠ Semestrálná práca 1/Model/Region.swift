//
//  Region.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

// MARK: - Katastrálne územie

import Foundation

struct Region {
    
    let id: UInt
    let name: String
    
}

extension Region: Comparable {
    
    static func < (lhs: Region, rhs: Region) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func > (lhs: Region, rhs: Region) -> Bool {
        return lhs.id > rhs.id
    }
    
    static func == (lhs: Region, rhs: Region) -> Bool {
        return lhs.id == rhs.id
    }
    
}
