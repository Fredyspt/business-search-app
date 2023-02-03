//
//  BusinessInfoViewController.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class BusinessInfoViewController: UIViewController {
    
    var businessInfoView: BusinessInfoView!
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        businessInfoView = BusinessInfoView()
        view.addSubview(businessInfoView)
        businessInfoView.pinEdgesToSuperviewEdges()
        
        businessInfoView.configure(with: business)
    }
}
