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
    @IBOutlet weak var maxOwnedListsSliderView: SliderView!
    @IBOutlet weak var maxOwnedPropertiesSliderView: SliderView!
    
    @IBOutlet weak var waitingWrapperView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
        @IBOutlet weak var generateButton: UIButton!
    
    
    fileprivate var viewModel = GeneratorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        regionSliderView.step = 2
        propertySliderview.step = 100
        ownedListSliderView.step = 10
        personSliderView.step = 100
        
        maxOwnedListsSliderView.step = 5
        maxOwnedPropertiesSliderView.step = 5

        hideKeyboardWhenTappedAround()
        waitingWrapperView.alpha = 0.0
        viewModel.setup(viewDelegate: self)
    }
    
    @IBAction func generateDataButtonPressed(_ sender: Any) {
        setWrapper {
            DispatchQueue.main.asyncAfter(seconds: 0.2) { [weak self] in
                
                let regionCount = Int(self?.regionSliderView.slider.value ?? 0)
                let propertiesCount = Int(self?.propertySliderview.slider.value ?? 0)
                let ownedListsCount = Int(self?.ownedListSliderView.slider.value ?? 0)
                let personsCount = Int(self?.personSliderView.slider.value ?? 0)
                let maxOwnedListsCount = Int(self?.maxOwnedListsSliderView.slider.value ?? 0)
                let maxOwnedPropertiesCount = Int(self?.maxOwnedPropertiesSliderView.slider.value ?? 0)
                
                self?.viewModel.generateData(regions: regionCount, properties: propertiesCount, persons: personsCount, ownerLists: ownedListsCount, maxOwnerLists: maxOwnedPropertiesCount, maxOwnersInList: maxOwnedListsCount)
                
            }
            
        }
    
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
