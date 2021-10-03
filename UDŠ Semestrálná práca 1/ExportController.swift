//
//  ExportController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ExportController: UIViewController {
    
    @IBOutlet weak var waitingScreenView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Export databázy"
        
        waitingScreenView.alpha = 0.0
        indicator.stopAnimating()
    }
    
    @IBAction func exportButtonPressed(_ sender: Any) {
        setWrapper {
            DispatchQueue.main.asyncAfter(seconds: 0.3, handler: {
                Database.shared.exportData() { [weak self] in
                    self?.waitingScreenView.alpha = 0.0
                    self?.indicator.stopAnimating()
                    
                    self?.composeAlert(title: "Export dokonceny", message: "Databaza bola úspešne migrovaná na disk") { _ in
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }
    }
    
    private func setWrapper(completion: @escaping () -> ()) {
        indicator.startAnimating()
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.waitingScreenView.alpha = 1.0
            self?.waitingScreenView.layoutIfNeeded()
        }
        completion()
    }
    
}
