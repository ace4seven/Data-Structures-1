//
//  ListViewModel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class ListViewModel {
    
    fileprivate weak var viewDelegate: ListViewDelegate?
    fileprivate let values: [ListType]
    
    init(values: [ListType]) {
        self.values = values
    }
    
}

extension ListViewModel: ListVM {
    
    func setup(viewDelegate: ListViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showData(items: values)
    }
    
}
