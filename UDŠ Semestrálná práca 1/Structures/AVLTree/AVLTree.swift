//
//  AVLTree.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() {}
}

// MARK: - Operations

extension AVLTree {
    
    // MARK: - INSERT
    
    mutating
    public func insert(_ value: Element) -> Bool {
        guard let root = self.root else {
            self.root = AVLNode(value: value)
            return true
        }
        
        var pivot = root
        while true {
            if (value < pivot.value) {
                guard let leftChild = pivot.leftChild else {
                    let node = AVLNode(value: value)
                    pivot.leftChild = node
                    node.parrent = pivot
                    break
                }
                pivot = leftChild
            } else if (value > pivot.value) {
                guard let rightChild = pivot.rightChild else {
                    let node = AVLNode(value: value)
                    pivot.rightChild = node
                    node.parrent = pivot
                    break
                }
                pivot = rightChild
            } else if (value == pivot.value) {
                return false
            }
        }
        
        while true {
            let balandedNode = balanced(pivot)
                
            balandedNode.height = Swift.max(balandedNode.leftHeight, balandedNode.rightHeight) + 1
            guard let parent = balandedNode.parrent else {
                self.root = balandedNode
                break
            }
            
            if parent.value > balandedNode.value {
                parent.leftChild = balandedNode
            } else {
                parent.rightChild = balandedNode
            }
            
            if balandedNode.value != pivot.value {
                break
            }
            
            pivot = parent
        }
        
        return true
    }
    
    // MARK: - CONTAINS
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
    
    // MARK: - FIND
    
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
    
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? { // Prerobit bez rekurzie
        guard let node = node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
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
                current = current?.leftChild
            }
            
            current = stack.peek()
            stack.pop()
            
            value(current!.value)
            
            current = current?.rightChild
        }
    }
    
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
