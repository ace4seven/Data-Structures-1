import Foundation

public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() {}
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

extension AVLTree {
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> { // UPRAVIT NEREKURZIVNE
        guard let node = node else {
            return AVLNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        let balancedNode = balanced(node)
        balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        
        return balancedNode
    }
    
}

extension AVLTree {
    
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
        default: return node }
    }
    
}

// MARK: - Rotations

extension AVLTree {
    
    // LEFT ROTACIA
    
    fileprivate func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild! // NODE bude korenom v substrome
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = Swift.max(node.leftHeight, node.rightHeight) + 1
        pivot.height = Swift.max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // RIGHT ROTACIA
    
    fileprivate func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
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
