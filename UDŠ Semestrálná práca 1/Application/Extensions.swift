//
//  Extensions.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 16/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation
import UIKit

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

extension UIColor {
    
    static let primary: UIColor = {
        return UIColor(red: 242.0 / 255, green: 144.0 / 255.0, blue: 47.0 / 255, alpha: 1.0)
    }()
    
    static let secondary: UIColor = {
        return UIColor(red: 255.0 / 255, green: 232.0 / 255.0, blue: 193.0 / 255, alpha: 1.0)
    }()
    
    static let background: UIColor = {
        return UIColor(red: 242.0 / 255, green: 144.0 / 255.0, blue: 47.0 / 255, alpha: 0.20)
    }()
    
}

extension String {
    
    func debugMessage() {
        if C.Settings.DEBUGMODE {
            print(self)
        }
    }
    
}
