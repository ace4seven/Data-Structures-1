//
//  ConfirmNewSharesViewModel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

class ConfirmNewSharesViewModel {
    
    fileprivate weak var viewDelegate: ConfirmNewSharesViewDelegate?
    fileprivate var shares = [Float]()
    fileprivate var ownedList: OwnedList
    
    init(ownedList: OwnedList) {
        self.ownedList = ownedList
        ownedList.shares.inOrder() { [weak self] share in
            self?.shares.append(share.shareCount)
        }
    }
    
}

extension ConfirmNewSharesViewModel: ConfirmNewSharesVM {
    
    func editShare(value: Float, index: Int) {
        shares[index] = value
    }
    
    func setup(viewDelegate: ConfirmNewSharesViewDelegate) {
        self.viewDelegate = viewDelegate
        
        viewDelegate.showItems(items: ownedList.shares.inOrderToArray())
    }
    
    func save() {
        var sum: Float = 0.0
        for share in shares {
            sum += share
        }
        if sum > 1.0 {
            viewDelegate?.errorSaveMessage()
        } else {
            Database.shared.updateSharesInOwnedList(ownedList: self.ownedList, newShares: shares)
            viewDelegate?.confirmSuccessMessage()
        }
    }
    
}
