//
//  AVLTree.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

// MARK: - VARIABLES

public class AVLTree<Element> {
    
    private let comparator: Comparator
    
    public private(set) var root: AVLNode<Element>?
    
    private var _count = 0
    
    var count:Int {
        get {
            return self._count
        }
    }
    
    public init(_ comparator: @escaping Comparator) {
        self.comparator = comparator
    }
    
}

// MARK: - Operations

extension AVLTree {
    
    // MARK: - INSERT
    @discardableResult
    public func insert(_ value: Element) -> Bool {
        guard let root = self.root else {
            self.root = AVLNode(value: value)
            _count += 1
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
        
        _count += 1
        rebalance(node: pivot)
        
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
    
    fileprivate func rebalance(node: AVLNode<Element>) {
        var pivot = node
        while true {
            let balandedNode = balanced(pivot)
            
            balandedNode.height = Swift.max(balandedNode.leftHeight, balandedNode.rightHeight) + 1
            guard let parent = balandedNode.parrent else {
                self.root = balandedNode
                break
            }
            
            switch comparator(parent.value, balandedNode.value) {
            case .orderedDescending:
                parent.leftChild = balandedNode
            default:
                parent.rightChild = balandedNode
            }
            
            
            if case .orderedSame = comparator(balandedNode.value, pivot.value) {
                pivot = parent
                continue
            }
            
            break
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
    
    @discardableResult
    public func remove(_ value: Element) -> Element? {
        
        var pivot = self.root
        
        while let current = pivot {
            switch comparator(value, current.value) {
            case .orderedAscending:
                pivot = current.leftChild
            case .orderedDescending:
                pivot = current.rightChild
            case .orderedSame:
                let result = current.value
                removeElement(current)
                 _count -= 1
                return result
            }
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
            if parent == nil {
                root = nil
            } else {
                rebalance(node: parent!)
            }
            node.parrent = nil
        } else if (node.leftChild != nil && node.rightChild == nil) {
            let child = node.leftChild
            child?.parrent = parent
            
            if let parentLeftChild = parent?.leftChild, case ComparisonResult.orderedSame = comparator(parentLeftChild.value, node.value) {
                parent?.leftChild = child
            } else if let parentRightChild = parent?.rightChild, case ComparisonResult.orderedSame = comparator(parentRightChild.value, node.value) {
                parent?.rightChild = child
            }
            
            node.parrent = nil
            
            if parent == nil {
                self.root = child
            } else {
                rebalance(node: child!)
            }
        } else if (node.leftChild == nil && node.rightChild != nil) {
            let child = node.rightChild
            child?.parrent = parent
            
            if let parentLeftChild = parent?.leftChild, case ComparisonResult.orderedSame = comparator(parentLeftChild.value, node.value) {
                parent?.leftChild = child
            } else if let parentRightChild = parent?.rightChild?.value, case ComparisonResult.orderedSame = comparator(parentRightChild, node.value) {
                parent?.rightChild = child
            }
            
            node.parrent = nil
            if parent == nil {
                self.root = child
            } else {
                rebalance(node: child!)
            }
        } else {
            let minNode = node.rightChild?.min
            let minValue = minNode?.value
            node.value = minValue!
            let minParrent = minNode?.parrent
            let minRightChild = minNode?.rightChild
            
            if minNode?.rightChild != nil {
                if let nodeRightChild = node.rightChild, let min = minValue, case ComparisonResult.orderedSame = comparator(nodeRightChild.value, min) {
                    node.rightChild = minRightChild
                    minRightChild?.parrent = node
                } else {
                    minNode?.rightChild?.parrent = minParrent
                    minParrent?.leftChild = minNode?.rightChild
                }
                minNode?.rightChild = nil
            } else {
                if let leftChild = minNode?.parrent?.leftChild?.value, let min = minNode?.value, case ComparisonResult.orderedSame = comparator(leftChild, min) {
                     minNode?.parrent?.leftChild = nil
                } else if minNode?.rightChild == nil && minNode?.leftChild == nil, let rightChild = minNode?.parrent?.rightChild?.value, let min = minNode?.value, case ComparisonResult.orderedSame = comparator(rightChild, min) {
                    node.rightChild = nil
                } else {
                    minParrent?.leftChild = nil
                }
            }
            if let parent = minParrent {
                rebalance(node: parent)
            }
            minNode?.parrent = nil
        }
    }
    
}

// TRAVERSIONS

extension AVLTree {
    
    func inOrder(value:  (Element) -> Void) {
        var stack = Stack<AVLNode<Element>>()
        var current = self.root

        while(current != nil || stack.isEmpty == false) {
            while(current != nil) {
                stack.push(current!)
                
                if C.Settings.TEST_STRUCTURE {
                    if abs(maxHeight(node: current?.leftChild) - maxHeight(node: current?.rightChild)) >= 2 {
                        print("CHYBA - BALANCE NIEJE KOREKTNE NASTAVENY")
                        return
                    }
                }
                
                current = current?.leftChild
            }

            current = stack.peek()
            stack.pop()

            value(current!.value)

            current = current?.rightChild
        }
    }
    
}

// MARK: - ARRAY TRANSFORM

extension AVLTree {
    
    func inOrderToArray() -> [Element] {
        var result = [Element]()
        result.reserveCapacity(self._count)
        self.inOrder() { value in
            result.append(value)
        }
        return result
    }
    
}

// MARK: - TESTING PURPUSE

extension AVLTree {
    
    fileprivate func maxHeight(node: AVLNode<Element>?) -> Int {
        return node == nil ?
            0 : Swift.max(
                maxHeight(node: node?.leftChild),
                maxHeight(node: node?.rightChild))
    }
    
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
