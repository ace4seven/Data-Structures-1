//
//  SearchPropertyViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol SearchPropertyVM: class {
    func setup(viewDelegate: SearchPropertyViewDelegate)
}

protocol SearchPropertyViewDelegate: class {
    func setupView(searchByID: Bool)
}
