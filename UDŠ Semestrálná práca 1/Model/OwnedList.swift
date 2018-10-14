//
//  OwnedList.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 14/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

struct OwnedList {
    
    let uniqueNumber: UInt
    let region: Region
    
    var properties: AVLTree<Property>
    
}

extension OwnedList: Comparable {
    
    static func < (lhs: OwnedList, rhs: OwnedList) -> Bool {
        return lhs.uniqueNumber < rhs.uniqueNumber
    }
    
    static func > (lhs: OwnedList, rhs: OwnedList) -> Bool {
        return lhs.uniqueNumber > rhs.uniqueNumber
    }
    
    static func == (lhs: OwnedList, rhs: OwnedList) -> Bool {
        return lhs.uniqueNumber == rhs.uniqueNumber
    }
    
}
