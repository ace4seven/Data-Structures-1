//
//  SearchOptionsViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol searchOptionsVM: class {
    func setup(delegate: SearchOptionsViewDelegate)
}

protocol SearchOptionsViewDelegate: class {
    func showOptions(tasks: [OptionType])
}
