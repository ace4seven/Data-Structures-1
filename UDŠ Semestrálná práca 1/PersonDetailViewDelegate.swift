//
//  PersonDetailViewDelegate.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

protocol PersonDetailVM: class {
    func setup(viewDelegate: PersonDetailViewDelegate)
}

protocol PersonDetailViewDelegate: class {
    func showPersonDetail(person: Person)
}

