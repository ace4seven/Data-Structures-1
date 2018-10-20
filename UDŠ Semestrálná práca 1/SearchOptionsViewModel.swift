//
//  SearchOptionsViewModdel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class SearchOptionsViewModel {
    
    fileprivate weak var viewDelegate: SearchOptionsViewDelegate?
    
}

extension SearchOptionsViewModel: searchOptionsVM {
    
    func setup(delegate: SearchOptionsViewDelegate) {
        self.viewDelegate = delegate
        
        viewDelegate?.showOptions(tasks: optionTypes())
    }
    
}

extension SearchOptionsViewModel {
    
    fileprivate func optionTypes() -> [OptionType] {
        let image = UIImage(named: "magnifier_ico")!
        return [
            .task(
                Option(number: 7,
                       desc: "Výpis  nehnuteľností  v  zadanom  katastrálnom  území", image: image)),
            .task(
                Option(number: 8,
            desc: "Výpis  všetkých  nehnuteľností  majiteľa  (definovaný  rodným  číslom)  v zadanom katastrálnom území (definované jeho číslom) aj s jeho majetkovými podielmi na nich", image: image)),
            .task(
                Option(number: 9, desc: "Výpis  všetkých  nehnuteľností  majiteľa  (definovaný  rodným  číslom)  aj  s jeho majetkovými podielmi na nich.", image: image))
            
        ]
    }
    
}
