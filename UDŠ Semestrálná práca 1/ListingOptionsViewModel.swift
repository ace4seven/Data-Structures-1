//
//  SearchOptionsViewModdel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/19/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class ListingOptionsViewModel {
    
    fileprivate weak var viewDelegate: ListingOptionsViewDelegate?
    
}

extension ListingOptionsViewModel: ListingOptionsVM {
    
    func setup(delegate: ListingOptionsViewDelegate) {
        self.viewDelegate = delegate
        
        viewDelegate?.showOptions(tasks: optionTypes())
    }
    
}

extension ListingOptionsViewModel {
    
    fileprivate func optionTypes() -> [OptionType] {
        let image = UIImage(named: "notes_tab_ico")!
        return [
            .task3(
                Option(number: 3,
                       desc: "Výpis  všetkých  osôb,  ktoré  majú  trvalý  pobyt  v  zadanej  nehnuteľnosti", image: image)),
            .task7(
                Option(number: 7,
            desc: "Výpis  nehnuteľností  v  zadanom  katastrálnom  území  (definované  názvom)  utriedených podľa ich súpisných čísel aj s ich popisom", image: image)),
            .task8(
            Option(number: 8, desc: "Výpis  všetkých  nehnuteľností  majiteľa  (definovaný  rodným  číslom)  v zadanom katastrálnom území (definované jeho číslom) aj s jeho majetkovými podielmi na nich.", image: image)),
            .task9(
            Option(number: 9, desc: "Výpis  všetkých  nehnuteľností  majiteľa  (definovaný  rodným  číslom)  aj  s jeho majetkovými podielmi na nich.", image: image)),
            .task15(
            Option(number: 15, desc: "Výpis všetkých katastrálnych území utriedených podľa ich názvov.", image: image)),
            
        ]
    }
    
}
