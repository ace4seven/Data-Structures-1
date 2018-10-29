//
//  ControlRegionViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/28/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol ControlRegionVM: ControlRegionCellDelegate {
    func setup(viewDelegate: ControlRegionViewDelegate)
    func reload()
    func preparePersonSegue()
}

protocol ControlRegionViewDelegate: class {
    func showRegions(regions: [Region])
    func goToProperties(for region: Region)
    func goToOwnedLists(for region: Region)
    func goToAllPersons(persons: [Person])
}
