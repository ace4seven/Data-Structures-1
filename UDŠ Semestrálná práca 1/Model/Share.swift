//
//  Shares.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public class Share {
    
    var percentage: Double
    var owners: [Double: Person] = [:]
    
    init(percentage: Double, owners: [Double: Person]) {
        self.percentage = percentage
        self.owners = owners
    }
    
}


