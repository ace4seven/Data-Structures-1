//
//  ApplicationCoordinator.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 02/10/2018.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        // Code below is for testing purposes
        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = .cyan
        rootViewController.pushViewController(emptyViewController, animated: false)
    }
    
    func start() {  // 6
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
}
