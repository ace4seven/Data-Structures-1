//
//  AVLTree.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public struct AVLTree<Element> {
    
    private let comparator: Comparator
    
    public private(set) var root: AVLNode<Element>?
    
    public init(comparator: @escaping Comparator) {
        self.comparator = comparator
    }
}

// MARK: - Operations

extension AVLTree {
    
    // MARK: - INSERT
    
    
    @discardableResult mutating
    public func insert(_ value: Element) -> Bool {
        guard let root = self.root else {
            self.root = AVLNode(value: value)
            return true
        }
        
        var pivot = root
        while true {
            var jumpOut = false
            
            switch (comparator(value, pivot.value)) {
            case .orderedSame:
                return false
            case .orderedAscending:
                guard let leftChild = pivot.leftChild else {
                    let node = AVLNode(value: value)
                    pivot.leftChild = node
                    node.parrent = pivot
                    jumpOut = true
                    break
                }
                pivot = leftChild
            case .orderedDescending:
                guard let rightChild = pivot.rightChild else {
                    let node = AVLNode(value: value)
                    pivot.rightChild = node
                    node.parrent = pivot
                    jumpOut = true
                    break
                }
                pivot = rightChild
            }
            
            if jumpOut { break }
        }
        
//        while true {
//            let balandedNode = balanced(pivot)
//
//            balandedNode.height = Swift.max(balandedNode.leftHeight, balandedNode.rightHeight) + 1
//            guard let parent = balandedNode.parrent else {
//                self.root = balandedNode
//                break
//            }
//
//            switch comparator(parent.value, balandedNode.value) {
//            case .orderedDescending:
//                parent.leftChild = balandedNode
//            default:
//                parent.rightChild = balandedNode
//            }
//
//
//            if case .orderedSame = comparator(balandedNode.value, pivot.value) {
//                pivot = parent
//                continue
//            }
//
//            break
//        }
        
        return true
    }
    
    // MARK: - CONTAINS
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            switch comparator(node.value, value) {
            case .orderedAscending:
                current = node.leftChild
            case .orderedDescending:
                current = node.rightChild
            case .orderedSame:
                return true
            }
        }
        return false
    }
    
    // MARK: - FiND BY ELEMENT
    
    public func findBy(element: Element) -> Element? {
        var pivot = self.root
        while let current = pivot {
            
            switch comparator(element, current.value) {
            case .orderedAscending:
                pivot = pivot?.leftChild
            case .orderedDescending:
                pivot = pivot?.rightChild
            case .orderedSame:
                return current.value
            }
        }
        return nil
    }
    
}

private extension AVLNode {
    
    var min: AVLNode {
        return leftChild?.min ?? self
    }
}

// MARK: - Fileprivates

extension AVLTree {
    
    fileprivate func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default: return node
        }
    }
    
}

// MARK: - Rotations

extension AVLTree {
    
    // LEFT ROTACIA
    
    fileprivate func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
        let parent = node.parrent
        
        if pivot.leftChild != nil {
            pivot.leftChild?.parrent = node
        }
        node.rightChild = pivot.leftChild
        
        node.parrent = pivot
        pivot.leftChild = node
        
        pivot.parrent = parent
        
        node.height = Swift.max(node.leftHeight, node.rightHeight) + 1
        pivot.height = Swift.max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // RIGHT ROTACIA
    
    fileprivate func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        let parent = node.parrent
        
        if pivot.rightChild != nil {
            pivot.rightChild?.parrent = node
        }
        node.leftChild = pivot.rightChild
        
        node.parrent = pivot
        pivot.rightChild = node
        
        pivot.parrent = parent
        
        node.height = Swift.max(node.leftHeight, node.rightHeight) + 1
        pivot.height = Swift.max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    fileprivate func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
    
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    fileprivate func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
    
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
}

extension AVLTree {
    
    public mutating func remove(_ value: Element) -> Element? {
        
        var pivot = self.root
        
        while let current = pivot {
            var found = false
            switch comparator(value, current.value) {
            case .orderedAscending:
                pivot = current.leftChild
            case .orderedDescending:
                pivot = current.rightChild
            case .orderedSame:
                found = true
                let result = current.value
                removeElement(current)
                return result
            }
            if found { break }
        }
        
        
        return nil
    }
    
    private func removeElement(_ node: AVLNode<Element>) {
        let parent = node.parrent
        if (node.leftChild == nil && node.rightChild == nil) {
            if let leftChildValue = parent?.leftChild?.value, case ComparisonResult.orderedSame = comparator(leftChildValue, node.value) {
                parent?.leftChild = nil
            } else {
                parent?.rightChild = nil
            }
            node.parrent = nil
            // TODO REBALANCE
        } else if (node.leftChild != nil && node.rightChild == nil) {
            let child = node.leftChild
            child?.parrent = parent
            parent?.leftChild = child
            node.leftChild = nil
            node.parrent = nil
        } else if (node.leftChild == nil && node.rightChild != nil) {
            let child = node.rightChild
            child?.parrent = parent
            parent?.rightChild = child
            node.rightChild = nil
            node.parrent = nil
        } else {
            let minNode = node.rightChild?.min
            node.value = minNode!.value
            
            if minNode?.rightChild != nil {
              minNode?.rightChild?.parrent = minNode?.parrent
                minNode?.parrent?.rightChild = minNode?.rightChild
                minNode?.rightChild = nil
                minNode?.leftChild = nil
            }
            minNode?.parrent = nil
        
//            if let leftChild = minNode?.parrent?.leftChild?.value, let min = minNode?.value, case ComparisonResult.orderedSame = comparator(leftChild, min) {
//                if minNode?.leftChild != nil {
//                    minNode?.leftChild?.parrent = node
//                    node.leftChild = minNode?.leftChild
//                    minNode?.leftChild = nil
//                    minNode?.parrent = nil
//                }
//
//                minNode?.parrent?.leftChild = nil
//                minNode?.parrent = nil
//            } else if let rightChild = minNode?.parrent?.rightChild?.value, let min = minNode?.value, case ComparisonResult.orderedSame = comparator(rightChild, min) {
//                if minNode?.rightChild != nil {
//                    minNode?.rightChild?.parrent = node
//                    node.rightChild = minNode?.rightChild
//                    minNode?.rightChild = nil
//                    minNode?.parrent = nil
//                }
//
//                minNode?.parrent?.rightChild = nil
//                minNode?.parrent = nil
//            }
            
        }
    }
    
//    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
//        guard let node = node else {
//            return nil
//        }
//        if value == node.value {
//            if node.leftChild == nil && node.rightChild == nil {
//                return nil
//            }
//            if node.leftChild == nil {
//                return node.rightChild
//            }
//            if node.rightChild == nil {
//                return node.leftChild
//            }
//            node.value = node.rightChild!.min.value
//            node.rightChild = remove(node: node.rightChild, value: node.value)
//        } else if value < node.value {
//            node.leftChild = remove(node: node.leftChild, value: value)
//        } else {
//            node.rightChild = remove(node: node.rightChild, value: value)
//        }
//        return node
//    }
    
}

// TRAVERSIONS

extension AVLTree {
    
    func inOrder(value:  (Element) -> Void) {
        var stack = Stack<AVLNode<Element>>()
        var current = self.root

        while(current != nil || stack.isEmpty == false) {
            while(current != nil) {
                stack.push(current!)
                current = current?.leftChild
            }

            current = stack.peek()
            stack.pop()

            value(current!.value)

            current = current?.rightChild
        }
    }
//
//    func inOrder(value:  (Element) -> Void) {
//        var pivot = self.root
//
//        while let current = pivot {
//            let min = current.min
//            value(min.value)
//
//
//        }
//    }
    
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
