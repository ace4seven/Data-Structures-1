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
}

extension GeneratorViewModel: GeneratorVM {
    
    func setup(viewDelegate: GeneratorViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func generateData(regions: Int, properties: Int) {
        self.propertiesCount = properties
        self.regionsCount = regions
        
        Database.shared.generateRegion(count: regionsCount) {
            debugPrint("Regions has been generated")
            Database.shared.generateProperty(count: propertiesCount) {
                debugPrint("Properties for regions has been generated")
                print(Database.shared.getRegions(sortedBy: .sortedByID))
                print(Database.shared.getRegions(sortedBy: .sortedByName))
            }
        }
    }
    
}
