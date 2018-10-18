//
//  Extensions.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 16/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

extension Int {
    
    public static let comparator: Comparator = { left, right in
        guard let l = left as? Int, let r = right as? Int else { return ComparisonResult.orderedSame }
        if l > r {
            return ComparisonResult.orderedDescending
        } else if l < r {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedSame
        }
    }
    
}
