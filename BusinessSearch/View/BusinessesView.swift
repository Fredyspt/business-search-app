//
//  BusinessesView.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class BusinessesView: UIView {

    lazy var businessesTable: UITableView = {
        let businessesTable = UITableView()
        businessesTable.backgroundColor = UIColor(named: "BackgroundColor")
        businessesTable.allowsSelection = true
        businessesTable.register(BusinessCell.self, forCellReuseIdentifier: BusinessCell.identifier)
        businessesTable.translatesAutoresizingMaskIntoConstraints = false
        return businessesTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(businessesTable)
        setConstraints()
    }
    
    private func setConstraints() {
        businessesTable.pinEdgesToSuperviewEdges()
    }
}
