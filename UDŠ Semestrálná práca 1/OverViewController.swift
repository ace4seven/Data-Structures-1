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
        
        var tree = AVLTree<Int>()
        
        for i in 0...1000000 {
            tree.insert(i)
        }
        
        tree.inOrder { value in
            print(value)
        }
        
    }
    
    
}

