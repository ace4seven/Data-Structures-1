import Foundation

public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() {}
    
    fileprivate enum RotationNode {
        case left(node: AVLNode<Element>)
        case right(node: AVLNode<Element>)
        case rightLeft(node: AVLNode<Element>)
        case leftRight(node: AVLNode<Element>)
        case none(node: AVLNode<Element>)
    }

}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

extension AVLTree {
    
    mutating
    public func insert(_ value: Element) {
        do { try insertData(value: value) }
        catch(let error) {
           debugPrint(error)
        }
    }
    
    mutating
    private func insertData(value: Element) throws {
        guard let root = self.root else {
            self.root = AVLNode(value: value)
            return
        }
        
        var tempStack = Stack<AVLNode<Element>>()
        tempStack.push(root)
        
        var pivot = root
        while (true) {
            if (value < pivot.value) {
                guard let leftChild = pivot.leftChild else {
                    let node = AVLNode(value: value)
                    pivot.leftChild = node
                    node.parrent = pivot
                    tempStack.push(node)
                    break
                }
                pivot = leftChild
                tempStack.push(leftChild)
            } else if (value > pivot.value) {
                guard let rightChild = pivot.rightChild else {
                    let node = AVLNode(value: value)
                    pivot.rightChild = node
                    node.parrent = pivot
                    tempStack.push(node)
                    break
                }
                pivot = rightChild
                tempStack.push(rightChild)
            } else if (value == pivot.value) {
                throw AppError.identicalKey
            }
        }
        
//        while let current = pivot.parrent {
//            
//        }
//        
    
        // MARK: - Asi nezmysel
        while(!tempStack.isEmpty) {
            guard let node = tempStack.pop() else {
                break
            }
            let rotatedNode = balanced(node)
            
            switch rotatedNode {
            case .left(let balancedNode):
                balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
                fixPointers(parent: tempStack.peek(), node: balancedNode, joinLeft: false)
            case .right(let balancedNode):
                balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
                fixPointers(parent: tempStack.peek(), node: balancedNode, joinLeft: true)
            case .leftRight(let balancedNode):
                balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
                fixPointers(parent: tempStack.peek(), node: balancedNode, joinLeft: true)
            case .rightLeft(let balancedNode):
                balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
                fixPointers(parent: tempStack.peek(), node: balancedNode, joinLeft: false)
            case .none(let noode):
                node.height = Swift.max(noode.leftHeight, noode.rightHeight) + 1
            }
            
        }
        
    }
    
    mutating
    private func fixPointers(parent: AVLNode<Element>?, node: AVLNode<Element>, joinLeft: Bool) {
        guard let parent = parent else {
            self.root = node
            self.root?.height = Swift.max(node.leftHeight, node.rightHeight) + 1
            return
        }
        
        if joinLeft {
            parent.leftChild = node
        } else {
            parent.rightChild = node
        }
    }
    
//    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> { // UPRAVIT NEREKURZIVNE
//        guard let node = node else {
//            return AVLNode(value: value)
//        }
//
//        if value < node.value {
//            node.leftChild = insert(from: node.leftChild, value: value)
//        } else {
//            node.rightChild = insert(from: node.rightChild, value: value)
//        }
//
//        let balancedNode = balanced(node)
//        balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
//
//        return balancedNode
//    }
    
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
    
    fileprivate func balanced(_ node: AVLNode<Element>) -> RotationNode {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return RotationNode.leftRight(node: leftRightRotate(node))
            } else {
                return RotationNode.right(node: rightRotate(node))
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return RotationNode.rightLeft(node: rightLeftRotate(node))
            } else {
                return RotationNode.left(node: leftRotate(node))
            }
        default: return RotationNode.none(node: node) }
    }
    
}

// MARK: - Rotations

extension AVLTree {
    
    // LEFT ROTACIA
    
    fileprivate func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
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
