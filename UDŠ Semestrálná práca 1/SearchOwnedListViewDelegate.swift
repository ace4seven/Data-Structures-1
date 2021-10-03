//
//  SearchOwnedListViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol SearchOwnedListVM: class {
    func setup(viewDelegate: SearchOwnedListViewDelegate)
}

protocol SearchOwnedListViewDelegate: class {
    func setupView(searchByID: Bool)
}
