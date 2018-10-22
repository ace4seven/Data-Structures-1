public class AVLNode<Element> {
    
    public var height = 1
    
    public var value: Element
    
    public var parrent: AVLNode?
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    
    var min: AVLNode {
        get {
            return leftChild?.min ?? self
        }
    }
    
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
        return leftChild?.height ?? 0
    }
    
    public var rightHeight: Int {
        return rightChild?.height ?? 0
    }
    
}

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
