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
    
}

extension GeneratorViewModel: GeneratorVM {
    
    func generateData(regions: Int, properties: Int, persons: Int, ownerLists: Int, maxOwnerLists: Int, maxOwnersInList: Int) {
        
       Database.shared.generateDatabase(regionsCount: regions, propertiesCount: properties, personsCount: persons, ownedListsCount: ownerLists, maxOwnerPropertiesCount: maxOwnerLists, maxOwnerInListCount: maxOwnersInList)
        viewDelegate?.pop()
    }
    
    
    func setup(viewDelegate: GeneratorViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
}
