//
//  GeneratorViewModel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class GeneratorViewModel {
    fileprivate weak var viewDelegate: GeneratorViewDelegate?
    
    fileprivate var propertiesCount = 0
    fileprivate var regionsCount = 0
    fileprivate var peopleCount = 0
}

extension GeneratorViewModel: GeneratorVM {
    
    func setup(viewDelegate: GeneratorViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func generateData(regions: Int, properties: Int, persons: Int) {
        self.propertiesCount = properties
        self.regionsCount = regions
        self.peopleCount = persons
        
        Database.shared.generateDatabase(regionCount: regionsCount, propertyCount: propertiesCount, persons: peopleCount) { [weak self] in
            self?.viewDelegate?.pop()
        }
    }
    
}
