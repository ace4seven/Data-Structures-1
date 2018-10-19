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
//        bugHunter()
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
        var deletedNumbers = [Int]()
        
        var index = 0
        
        while(index < 100000) {
            let number = Int.random(in: 1...50000000)
            if tree.insert(number) {
                index += 1
                testArray.append(number)
            }
        }
        
        var deleted = 0;
        
        for i in 0...1000000 {
            if (tree.remove(i) != nil) {
                print("MAZEM \(i)")
                deleted += 1;
                deletedNumbers.append(i)
            }
        }
    
        var a = [Int]()
        
        tree.inOrder() { value in
            a.append(value)
            testTreeArray.append(value)
        }
        
        var sorttedTestArray = testArray.sorted()
        
        if (sorttedTestArray.count - deleted) == testTreeArray.count {
            print("TESTY OOOOK")
        }
        
        print(tree)
        
        print(deleted)
        print(testTreeArray.count)
        print(sorttedTestArray.count)
        
    
    }
    
    fileprivate func bugHunter() {
        var tree = AVLTree<Int>(comparator: Int.comparator)
        tree.insert(29)
        tree.insert(15)
        tree.insert(42)
        tree.insert(40)
        tree.insert(13)
        tree.insert(44)
        tree.insert(21)
        tree.insert(20)
        tree.insert(33)
        tree.insert(14)

        tree.remove(13)
        tree.remove(15)
        tree.remove(29)
        tree.remove(33)
        tree.remove(40)
        tree.remove(42)
        tree.remove(44)
        
        print(tree)
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
        
        tree.remove(32)
        tree.remove(11)
        tree.remove(65)
        tree.remove(91)
        tree.remove(41)
        tree.remove(50)
        tree.remove(72)
        tree.remove(99)

        print(tree)
        
        tree.inOrder() {
            print($0)
        }
    }
    
    
}

