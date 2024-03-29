//
//  ListingOptionsViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol ListingOptionsVM: class {
    func setup(delegate: ListingOptionsViewDelegate)
    func showRegionsOrderedByName()
}

protocol ListingOptionsViewDelegate: class {
    func showOptions(tasks: [OptionType])
    func goToRegionList(regions: [Region])
}
