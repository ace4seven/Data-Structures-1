//
//  PersonDetailViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class PersonDetailViewModel {
    
    fileprivate weak var viewDelegate: PersonDetailViewDelegate?
    fileprivate let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
}

extension PersonDetailViewModel: PersonDetailVM {
    func setup(viewDelegate: PersonDetailViewDelegate) {
        self.viewDelegate = viewDelegate
        
        self.viewDelegate?.showPersonDetail(person: person)
    }
}
