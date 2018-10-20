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
                Option(number: 1,
                       desc: "Vyhľadanie  nehnuteľnosti  podľa  súpisného  čísla  a čísla  katastrálneho  územia", image: image)),
            .task(
                Option(number: 2,
            desc: "Vyhľadanie  obyvateľa  podľa  rodného  čísla  a  výpis  jeho  trvalého  pobytu", image: image)),
            .task(
                Option(number: 4, desc: "Vyhľadanie  listu  vlastníctva  podľa  jeho  čísla  a čísla  katastrálneho  územia.", image: image)),
            .task(
                Option(number: 5, desc: "Vyhľadanie  nehnuteľnosti  podľa  súpisného  čísla  a názvu  katastrálneho  územia.", image: image)),
            .task(
                Option(number: 6, desc: "Vyhľadanie listu vlastníctva  podľa  jeho  čísla  a názvu  katastrálneho  územia.", image: image)),
            
        ]
    }
    
}
