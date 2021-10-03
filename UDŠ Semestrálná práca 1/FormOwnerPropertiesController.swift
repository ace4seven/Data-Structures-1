//
//  FormOwnerPropertiesController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class FormOwnerPropertiesController: UIViewController {
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var regionIDTextfield: UITextField!
    @IBOutlet weak var personalIDTextfield: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        indicator.alpha = 0.0
        title = "Výpisy nehnuteľností majiteľa"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController {
            if let propertiesShare = sender as? [PropertyShare] {
                let viewModel = ListViewModel(values: propertiesShare.map { .propertyWithShare($0) })
                vc.viewModel = viewModel
            }
            
            if let regions = sender as? [Region] {
                let viewModel = ListViewModel(values: regions.map { .region($0) })
                vc.viewModel = viewModel
            }
            
            if let persons = sender as? [Person] {
                let viewModel = ListViewModel(values: persons.map { .person($0) })
                vc.viewModel = viewModel
            }
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        indicator.alpha = 1.0
        indicator.startAnimating()
        
        guard let regionID = UInt(regionIDTextfield.text ?? ""), let personalID = personalIDTextfield.text else {
            composeAlert(title: "Chyba", message: "Zadajte správne ID regionu") { [weak self] _ in
                self?.indicator.alpha = 0.0
                self?.indicator.stopAnimating()
            }
            return
        }
        
        Database.shared.listOwnerProperties(personalID: personalID, regionID: regionID) { [weak self] values in
            guard let properties = values else {
                self?.indicator.alpha = 0.0
                self?.indicator.stopAnimating()
                self?.composeAlert(title: "Región nenájdený", message: "Ľutujeme, ale región s danými parametrami systém nenašiel", completion: { _ in
                })
                return
            }
            self?.indicator.alpha = 0.0
            self?.indicator.stopAnimating()
            
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: properties)
        }
    }
    
    @IBAction func regionListButtonPressed(_ sender: Any) {
        Database.shared.getRegionsSortedByName() { [weak self] regions in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
        }
    }
    
    @IBAction func personListButtonPressed(_ sender: Any) {
        Database.shared.getPersons() { [weak self] persons in
            self?.performSegue(withIdentifier: String(describing: ListController.self), sender: persons)
        }
    }
    
}

