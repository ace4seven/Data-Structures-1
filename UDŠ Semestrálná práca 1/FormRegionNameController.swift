//
//  FormRegionNameController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class FormRegionNameController: UIViewController {

    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.alpha = 0.0
        title = "Výpisy nehnuteľností"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController {
            if let properties = sender as? [Property] {
                let viewModel = ListViewModel(values: properties.map { .property($0) })
                vc.viewModel = viewModel
            }
            
            if let regions = sender as? [Region] {
                let viewModel = ListViewModel(values: regions.map { .region($0) })
                vc.viewModel = viewModel
            }
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        actionButton.isEnabled = false
        indicator.alpha = 1.0
        indicator.startAnimating()
        
        guard let name = nameTextField.text else { return }
        
        Database.shared.getProperties(regionName: name) { [weak self] values in
            guard let properties = values else {
                self?.indicator.alpha = 0.0
                self?.indicator.stopAnimating()
                self?.composeAlert(title: "Región nenájdený", message: "Ľutujeme, ale región s danými parametrami systém nenašiel", completion: { _ in
                    self?.actionButton.isEnabled = true
                })
                return
            }
            self?.indicator.alpha = 0.0
            self?.indicator.stopAnimating()
            
            self?.actionButton.isEnabled = true
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: properties)
        }
    }
    
    @IBAction func regionListButtonPressed(_ sender: Any) {
        Database.shared.getRegionsSortedByName() { [weak self] regions in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
        }
    }
}
