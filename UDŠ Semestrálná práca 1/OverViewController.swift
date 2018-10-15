//
//  ViewController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 02/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

// MARK: - Variables

class OverViewController: UIViewController {

}

// MARK: - LifeCycle

extension OverViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testData()
    }

    
}

// MARK: - Fileprivates

extension OverViewController {
    
    fileprivate func testData() {
//        Database.shared.generatePersons(count: 100)
//        print(Database.shared.persons)
        
        var tree = AVLTree<Int>()
        
        for i in  stride(from: 20, to: 1, by: -1) {
            tree.insert(Int.random(in: 1...1000))
//            tree.insert(i)
        }
        
//        tree.insert(10)
//        tree.insert(9)
//        tree.insert(8)
//        tree.insert(7)
//        tree.insert(6)
//        tree.insert(5)
//        tree.insert(4)
//        tree.insert(3)
//        tree.insert(2)
//        tree.insert(1)
//        tree.insert(3)
//
        tree.inOrder() { value in
            print(value)
        }
        
        print(tree)
    }
    
    
}

