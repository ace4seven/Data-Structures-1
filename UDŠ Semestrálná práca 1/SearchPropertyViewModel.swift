//
//  SearchPropertyViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/23/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class SearchPropertyViewModel {
    
    fileprivate weak var viewDelegate: SearchPropertyViewDelegate?
    fileprivate let searchByID: Bool
    
    init(searchByID: Bool) {
        self.searchByID = searchByID
    }
}

extension SearchPropertyViewModel: SearchPropertyVM {
    
    func setup(viewDelegate: SearchPropertyViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.setupView(searchByID: searchByID)
    }
}
