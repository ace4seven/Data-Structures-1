//
//  LinkedList.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 06/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public struct LinkedList<T> {
    
    public var head: LinkedNode<T>?
    public var tail: LinkedNode<T>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
}

extension LinkedList {
    
    fileprivate func node(at index: Int) -> LinkedNode<T>? {
        var currentNode     = head
        var currentIndex    = 0
    
        while currentNode != nil && currentIndex < index {
            currentNode     = currentNode!.next
            currentIndex    += 1
        }
        
        return currentNode
    }
    
}

extension LinkedList {
    
    mutating func push(_ value: T) {
        self.head = LinkedNode(value: value, next: head)
        
        if tail == nil {
            self.tail = head
        }
    }
    
    public mutating func append(_ value: T) {
        
        guard !isEmpty else {
            push(value)
            return
        }
        
        self.tail!.next = LinkedNode(value: value)
        
        tail = self.tail!.next
    }
    
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
    
}
