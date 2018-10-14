//
//  Node.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 06/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public class LinkedNode<T> {
    
    public var value: T
    public var next: LinkedNode?
    
    public init(value: T, next: LinkedNode? = nil) {
        self.value = value
        self.next = next
    }
    
}

extension LinkedNode: CustomStringConvertible {
    
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
    
}
