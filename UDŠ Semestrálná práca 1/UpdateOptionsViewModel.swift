//
//  UpdateOptionsViewModel.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation
import UIKit

class UpdateOptionsViewModel {
    
    fileprivate weak var viewDelegate: UpdateOptionsViewDelegate?
    
}

extension UpdateOptionsViewModel: UpdateOptionsVM {
    
    func setup(delegate: UpdateOptionsViewDelegate) {
        self.viewDelegate = delegate
        
        viewDelegate?.showOptions(tasks: optionTypes())
    }
    
}

extension UpdateOptionsViewModel {
    
    fileprivate func optionTypes() -> [OptionType] {
        let image = UIImage(named: "update_tab_ico")!
        return [
            .task10(
                Option(number: 10,
        desc: "Zápis nového trvalého pobytu obyvateľa  (definovaný  rodným  číslom)  do  nehnuteľnosti (definovaná  súpisným  číslom)  v  zadanom  katastrálnom  území  (definované  jeho názvom).", image: image)),
            .task11(
                Option(number: 11,
            desc: "Zmena  majiteľa  (definovaný  rodným  číslom)  nehnuteľnosti  (definovaná  súpisným číslom)  v zadanom  katastrálnom  území  (definované  jeho  číslom).  Nový  majiteľ  je definovaný rodným číslom.", image: image)),
            .task12(
            Option(number: 12, desc: "Zapísanie/Zmena  majetkového  podielu  majiteľa  (definovaný  rodným  číslom)  na  list vlastníctva  (definovaný  číslom)  v  zadanom  katastrálnom  území  (definované  jeho číslom). ", image: image)),
            .task13(
            Option(number: 13, desc: "Odstránenie  majetkového  podielu  majiteľa  (definovaný  rodným  číslom)  z  listu vlastníctva  (definovaný  číslom)  v  zadanom  katastrálnom  území  (definované  jeho číslom).  Zároveň  sa  nastavia  nové  majetkové  podiely  ostatných  vlastníkov  (definovaní svojim rodným číslom).", image: image)),
            .task16(
            Option(number: 16, desc: "Pridanie občana.", image: image)),
            .task17(
                Option(number: 17, desc: "Pridanie listu vlastníctva do zadaného katastrálneho územia (definované názvom)", image: image)),
            .task18(
            Option(number: 18, desc: "Pridanie  nehnuteľnosti  na  list  vlastníctva  (definovaný  číslom)  v  zadanom  katastrálnom území (definované jeho číslom)", image: image)),
            .task19(
            Option(number: 19, desc: "Odstránenie  listu  vlastníctva  (definovaný  číslom)  v  zadanom  katastrálnom  území (definované  jeho  číslom).  Nehnuteľnosti  a majetkové  podiely  sa  presunú  na  iný  list vlastníctva (definovaný číslom).", image: image)),
            .task20(
            Option(number: 20, desc: "Odstránenie nehnuteľnosti (definovaná popisným číslom) z listu vlastníctva (definovaný číslom) v zadanom katastrálnom území (definované jeho číslom). ", image: image)),
            .task21(
                Option(number: 21, desc: "Pridanie katastrálneho územia. ", image: image)),
            .task22(
            Option(number: 22, desc: "Odstránenie  katastrálneho  územia  (definované  jeho  číslom).  Agenda  sa  presunie  do iného katastrálneho územia (definované jeho číslom).", image: image)),
            
        ]
    }
    
}
