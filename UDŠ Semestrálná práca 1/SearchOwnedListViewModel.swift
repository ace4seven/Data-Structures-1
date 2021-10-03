//
//  SearchOwnedListViewModel.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class SearchOwnedListViewModel {
    
    fileprivate weak var viewDelegate: SearchOwnedListViewDelegate?
    fileprivate let searchByID: Bool
    
    init(searchByID: Bool) {
        self.searchByID = searchByID
    }
}

extension SearchOwnedListViewModel: SearchOwnedListVM {
    
    func setup(viewDelegate: SearchOwnedListViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.setupView(searchByID: searchByID)
    }
}
