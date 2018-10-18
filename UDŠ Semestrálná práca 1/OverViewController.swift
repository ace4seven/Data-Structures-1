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
        
//        testDelete()
        
    }

    
}

// MARK: - Fileprivates

extension OverViewController {
    
    fileprivate func testData() {
//        Database.shared.generatePersons(count: 100)
//        print(Database.shared.persons)
        
        var tree = AVLTree<Int>(comparator: Int.comparator)
        var testArray = [Int]()
        var testTreeArray = [Int]()
        
        var index = 0
        
        while(index < 10) {
            let number = Int.random(in: 1...1000)
            if tree.insert(number) {
                index += 1
                testArray.append(number)
            }
        }
    
        var a = [Int]()
        
        tree.inOrder() { value in
            a.append(value)
            testTreeArray.append(value)
        }
        
        var sorttedTestArray = testArray.sorted()
        
        for i in 0..<sorttedTestArray.count {
            if (sorttedTestArray[i] != testTreeArray[i]) {
                print("CHYBAAAAA")
                break
            }
        }
        
        print(tree)

        print("TESTY OK")
        
    
    }
    
    fileprivate func testDelete() {
        var tree = AVLTree<Int>(comparator: Int.comparator)
        
        tree.insert(41)
        tree.insert(20)
        tree.insert(11)
        tree.insert(29)
        tree.insert(32)
        tree.insert(65)
        tree.insert(50)
        tree.insert(91)
        tree.insert(72)
        tree.insert(73)
        tree.insert(99)
        
//        tree.remove(32)
//        tree.remove(11)
//        tree.remove(65)
        tree.remove(91)
        tree.remove(41)
        tree.remove(50)
        tree.remove(65)
        tree.remove(72)
        tree.remove(99)

        print(tree)
        
        tree.inOrder() {
            print($0)
        }
    }
    
    
}

