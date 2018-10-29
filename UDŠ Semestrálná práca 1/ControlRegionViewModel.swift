//
//  ControlRegionViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

final class ControlRegionViewModel {
    
    fileprivate weak var viewDelegate: ControlRegionViewDelegate?
    
}

extension ControlRegionViewModel: ControlRegionVM {
    
    func preparePersonSegue() {
        viewDelegate?.goToAllPersons(persons: Database.shared.getAllPersons())
    }
    
    func reload() {
        self.viewDelegate?.showRegions(regions: Database.shared.getRegions(key: SortKey.name))
    }
    
    func controlRegionOwnedListButtonPressed(region: Region) {
        viewDelegate?.goToOwnedLists(for: region)
    }
    
    func controlRegionPropertiesButtonPressed(region: Region) {
        self.viewDelegate?.goToProperties(for: region)
    }
    
    func setup(viewDelegate: ControlRegionViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showRegions(regions: Database.shared.getRegions(key: SortKey.name))
    }
    
}
