//
//  UpdateOptionsViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol UpdateOptionsVM: class {
    func setup(delegate: UpdateOptionsViewDelegate)
}

protocol UpdateOptionsViewDelegate: class {
    func showOptions(tasks: [OptionType])
}
