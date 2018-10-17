//
//  Extensions.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 16/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

extension Int: CustomComparable {
    
    public static func == (lhs: Any, rhs: Int) -> Bool {
        guard let lhs = lhs as? Int else { return false }
        return lhs == rhs
    }
    
    public static func > (lhs: Any, rhs: Int) -> Bool {
        guard let lhs = lhs as? Int else { return false }
        return lhs > rhs
    }
    
    
    public static func < (lhs: Any, rhs: Int) -> Bool {
        guard let lhs = lhs as? Int else { return false }
        return lhs < rhs
    }
    
}
