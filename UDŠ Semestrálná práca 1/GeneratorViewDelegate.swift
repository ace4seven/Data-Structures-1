//
//  GeneratorViewDelegate.swift
//  UDŠ Semestrálná práca 1
//
//  Created by Juraj Macák on 10/20/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

protocol GeneratorVM: class {
    func setup(viewDelegate: GeneratorViewDelegate)
    func generateData(regions: Int, properties: Int)
}

protocol GeneratorViewDelegate: class {
    func pop()
}
