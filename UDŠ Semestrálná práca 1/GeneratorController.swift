//
//  GeneratorController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class GeneratorController: UIViewController {
    
    @IBOutlet weak var regionTextfield: UITextField!
    @IBOutlet weak var propertiesTextField: UITextField!
    
    fileprivate var viewModel = GeneratorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setup(viewDelegate: self)
    }
    
    @IBAction func generateDataButtonPressed(_ sender: Any) {
        if let regionCount = Int(regionTextfield.text ?? ""), let propertiesCount = Int(propertiesTextField.text ?? "") {
            viewModel.generateData(regions: regionCount, properties: propertiesCount)
        }
    }
    
    
}

extension GeneratorController: GeneratorViewDelegate {
    
}

extension GeneratorController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
