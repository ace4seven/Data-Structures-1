//
//  Protocols.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 17/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public protocol CustomComparable: Comparable {
    
    static func < (lhs: Any, rhs: Self) -> Bool
    static func > (lhs: Any, rhs: Self) -> Bool
    static func == (lhs: Any, rhs: Self) -> Bool
    
}

public protocol Exportable {
    func toString() -> String
}
