//
//  GeneratorController.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class GeneratorController: UIViewController {
    
    @IBOutlet weak var regionSliderView: SliderView!
    @IBOutlet weak var propertySliderview: SliderView!
    
    @IBOutlet weak var ownedListSliderView: SliderView!
    @IBOutlet weak var personSliderView: SliderView!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var regionTextfield: UITextField!
    @IBOutlet weak var propertiesTextField: UITextField!
    @IBOutlet weak var waitingWrapperView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var personsTextField: UITextField!
    
    fileprivate var viewModel = GeneratorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        regionSliderView.step = 50
        propertySliderview.step = 1000
        ownedListSliderView.step = 100
        personSliderView.step = 500

        hideKeyboardWhenTappedAround()
//        waitingWrapperView.alpha = 0.0
        viewModel.setup(viewDelegate: self)
    }
    
    @IBAction func generateDataButtonPressed(_ sender: Any) {
//        setWrapper {
//            DispatchQueue.main.asyncAfter(seconds: 0.2) { [weak self] in
//                if let regionCount = Int(self?.regionTextfield.text ?? ""), let propertiesCount = Int(self?.propertiesTextField.text ?? ""),
//                    let personsCount = Int(self?.personsTextField.text ?? "") {
//                    self?.viewModel.generateData(regions: regionCount, properties: propertiesCount, persons: personsCount)
//                } else {
//                    self?.indicator.stopAnimating()
//                    self?.waitingWrapperView.alpha = 0.0
//                }
//            }
//        }
        
        self.viewModel.generateData(regions: 10, properties: 100, persons: 1000)
    }
    
    private func setWrapper(completion: @escaping () -> ()) {
        indicator.startAnimating()
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.waitingWrapperView.alpha = 1.0
            self?.waitingWrapperView.layoutIfNeeded()
        }
        completion()
    }
    
    
}

extension GeneratorController: GeneratorViewDelegate {
    
    func pop() {
        composeAlert(title: "Úspech", message: "Testovacie dáta boli úspešne vygenerované") { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

extension GeneratorController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
