//
//  ViewController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 02/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

// MARK: - Variables

class TestStructureController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testData(
            values: 1000,
            range: 1..<1000000,
            removePropability: 0.4,
            drawConsoleTree: true
        )
     
    }
    
}

// MARK: - Fileprivates

extension TestStructureController {
    
    fileprivate func testData(values: Int, range: Range<Int>, removePropability: Double, drawConsoleTree: Bool) {
        
        let tree = AVLTree<Int>(Int.comparator)
        var numberOfElements = 0;
        var deletedElements = 0;
        var deletedNumbers: Array = [Int]()
        var addedElements: Array = [Int]()
        
        // NAPLNENIE STROMU PRVKAMI a TEST 1 - KONTROLA BALANCE FAKTORA
        
        var index = 0
        while index < values {
            let number = Int.random(in: range)
            if tree.insert(number) {
                addedElements.append(number)
                tree.inOrder { _ in} //INORDER KONTROLA BALANCE FAKTORA
                numberOfElements += 1
                
                if Double.random(in: 0...1) <= removePropability {
                    var numberToDelete = addedElements[Int.random(in: 0..<addedElements.count)]
                    while tree.remove(numberToDelete) == nil {
                        numberToDelete = addedElements[Int.random(in: 0..<addedElements.count)]
                    }
                    
                    var count = 0
                    tree.inOrder { _ in
                        count += 1
                    }
                    
                    if count != tree.count {
                        print("CHYBA")
                        return
                    }
                    
                    numberOfElements -= 1
                    deletedElements += 1
                    
                    deletedNumbers.append(numberToDelete)
                    if let index = addedElements.firstIndex(of: numberToDelete) {
                        addedElements.remove(at: index)
                    }
                }
                index += 1
            }
        }
        
        print("TEST 1 - USPECH")
        
        // TEST 2 INORDER PORADIE MUSI SEDIET - ZORADENIE OD NAJMENSIEHO PO NAJVACSIE
        
        var previous: Int = 0
        var isFirst = true
        var treeCount = 0
        tree.inOrder { value in
            if !isFirst {
                if previous >= value {
                    print("CHYBA INORDER \(previous) je vacsie ako \(value)")
                    return
                }
            } else {
                isFirst = false
            }
            treeCount += 1
            previous = value
        }
        print("TEST 2 - USPECH")
    
        
        // TEST 3 POCET PRVKOV MUSI SEDIET S TYM, CO SA VLOZILO A CO ODSTRANILO
        
        if treeCount != numberOfElements {
            print("TEST 3 skoncil neuspesne")
            print("\(treeCount) - \(numberOfElements)")
        } else {
            print("TEST 3 - USPECH")
        }
        
        print("--------------------------------------")
        print("Pocet elementov: \(numberOfElements)")
        print("Pocet zmazanych: \(deletedElements)")
        print("--------------------------------------")
        
        if drawConsoleTree {
            print(tree)
        }
    }
    
}

