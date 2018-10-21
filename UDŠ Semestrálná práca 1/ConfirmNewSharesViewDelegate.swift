//
//  ConfirmNewSharesViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/21/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol ConfirmNewSharesVM: EditShareCellDelegate {
    func setup(viewDelegate: ConfirmNewSharesViewDelegate)
    func save()
}

protocol ConfirmNewSharesViewDelegate: class {
    func showItems(items: [Share])
    func errorSaveMessage()
    func confirmSuccessMessage()
}
