//
//  PersonDetailController.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/24/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import UIKit

class PersonDetailController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personalIDLabel: UILabel!
    @IBOutlet weak var propertyID: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    var viewModel: PersonDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail občana"
        viewModel?.setup(viewDelegate: self)
    }

}

extension PersonDetailController: PersonDetailViewDelegate {
    
    func showPersonDetail(person: Person) {
        nameLabel.text = person.fullName
        personalIDLabel.text = person.id
        
        guard let home = person.home else {
            propertyID.text = ""
            addressLabel.text = ""
            descTextView.text = ""
            return
        }
        propertyID.text = home.id.toString
        addressLabel.text = home.address
        descTextView.text = home.desc
    }
    
}
