//
//  Formatters.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

final class Formatters {
    
    static let formater = DateFormatter.init(format: "DDDD.MM.YYYY")
    
    static func dateToString(date: Date) -> String {
        return formater.string(from: date)
    }
    
}
