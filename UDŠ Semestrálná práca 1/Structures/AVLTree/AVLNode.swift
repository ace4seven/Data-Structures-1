public class AVLNode<Element> {
    
    public var height = 0
    
    public var value: Element
    
    public var parrent: AVLNode?
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    
    public init(value: Element) {
        self.value = value
    }
}

// MARK: - Balance Factor

extension AVLNode {
    
    public var balanceFactor: Int {
        return leftHeight - rightHeight
    }
    public var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    public var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    
}

// MARK: - Tree Traversions

//extension AVLNode {
//
//    public func traverseInOrder(visit: (Element) -> Void) { // prerobit, rekurzia
//        leftChild?.traverseInOrder(visit: visit)
//        visit(value)
//        rightChild?.traverseInOrder(visit: visit)
//    }
//
//    public func traversePreOrder(visit: (Element) -> Void) { // prerobit, rekurzia
//        visit(value)
//        leftChild?.traversePreOrder(visit: visit)
//        rightChild?.traversePreOrder(visit: visit)
//    }
//
//    public func traversePostOrder(visit: (Element) -> Void) { // prerobit, rekurzia
//        leftChild?.traversePostOrder(visit: visit)
//        rightChild?.traversePostOrder(visit: visit)
//        visit(value)
//    }
//
//}

extension AVLNode: CustomStringConvertible {
    
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value) b:\(node.balanceFactor) h:\(node.height)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value) b:\(node.balanceFactor) h:\(node.height)\n"
            + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
    
}
