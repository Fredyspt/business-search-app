//
//  SearchView.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class SearchView: UIView {

    //MARK: - UI Components
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "YelpLogo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var searchSection: UIStackView = {
        let searchSection = UIStackView()
        searchSection.axis = .horizontal
        searchSection.alignment = .center
        searchSection.distribution = .fillProportionally
        searchSection.spacing = 10
        return searchSection
    }()
    
    private lazy var searchFieldContainer: UIView = {
        let searchFieldContainer = UIView()
        searchFieldContainer.backgroundColor = .systemGray5
        searchFieldContainer.layer.cornerRadius = 25
        return searchFieldContainer
    }()
    
    lazy var searchField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 20)
        searchField.placeholder = "Search..."
        searchField.returnKeyType = .search
        return searchField
    }()
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 45)
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: largeConfig), for: .normal)
        searchButton.contentMode = .scaleAspectFill
        searchButton.tintColor = UIColor(named: "AccentColor")
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(logo)
        searchFieldContainer.addSubview(searchField)
        searchSection.addArrangedSubview(searchFieldContainer)
        searchSection.addArrangedSubview(searchButton)
        addSubview(searchSection)
        setConstraints()
    }
    
    private func setConstraints() {
        setLogoConstraints()
        setSearchSectionConstraints()
    }
    
    private func setLogoConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: searchSection.topAnchor, constant: -100),
            logo.heightAnchor.constraint(equalToConstant: 150),
            logo.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setSearchSectionConstraints() {
        searchSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchSection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchSection.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchSection.widthAnchor.constraint(equalToConstant: 300),
            searchSection.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        setSearchFieldConstraints()
    }
    
    private func setSearchFieldConstraints() {
        searchFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchFieldContainer.leadingAnchor.constraint(equalTo: searchSection.leadingAnchor),
            searchFieldContainer.topAnchor.constraint(equalTo: searchSection.topAnchor),
            searchFieldContainer.bottomAnchor.constraint(equalTo: searchSection.bottomAnchor),
            searchFieldContainer.widthAnchor.constraint(equalToConstant: 230),
            searchField.leadingAnchor.constraint(equalTo: searchFieldContainer.layoutMarginsGuide.leadingAnchor, constant: 10),
            searchField.topAnchor.constraint(equalTo: searchFieldContainer.layoutMarginsGuide.topAnchor),
            searchField.trailingAnchor.constraint(equalTo: searchFieldContainer.layoutMarginsGuide.trailingAnchor, constant: -10),
            searchField.bottomAnchor.constraint(equalTo: searchFieldContainer.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
