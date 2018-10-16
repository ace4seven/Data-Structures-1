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
        
//        testData()
        var tree = AVLTree<Int>()
        
        for i in 1...10 {
            tree.insert(i)
        }
        
        tree.inOrder() { value in
            print(value)
        }
        
        print(tree)
        
        tree.inOrder() { value in
            print(value)
        }
        
    }

    
}

// MARK: - Fileprivates

extension OverViewController {
    
    fileprivate func testData() {
//        Database.shared.generatePersons(count: 100)
//        print(Database.shared.persons)
        
        var tree = AVLTree<Int>()
        var testArray = [Int]()
        var testTreeArray = [Int]()
        
        var index = 0
        
        while(index < 100000) {
            let number = Int.random(in: 1...10000000)
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

        print("TESTY OK")
        
        
        
        
    
    }
    
    
}

