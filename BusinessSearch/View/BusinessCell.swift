//
//  BusinessCell.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    static let identifier = "BusinessCell"
    
    //MARK: - UI Components
    private lazy var businessImage: UIImageView = {
        let businessImage = UIImageView()
        businessImage.image = UIImage(systemName: "photo")
        businessImage.contentMode = .scaleAspectFill
        businessImage.clipsToBounds = true
        return businessImage
    }()
    
    private lazy var detailsSection: UIStackView = {
        let detailsSection = UIStackView()
        detailsSection.axis = .vertical
        detailsSection.alignment = .leading
        detailsSection.spacing = 8
        return detailsSection
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Business Name"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.text = "Business Address"
        addressLabel.font = UIFont.systemFont(ofSize: 16)
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    
    private lazy var ratingAndPriceSection: UIStackView = {
        let ratingAndPriceSection = UIStackView()
        ratingAndPriceSection.axis = .vertical
        ratingAndPriceSection.alignment = .trailing
        ratingAndPriceSection.spacing = 8
        return ratingAndPriceSection
    }()
    
    private lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.text = "⭐️"
        ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return ratingLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return priceLabel
    }()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configure(with business: Business) {
        if let imageUrl = business.image_url {
            businessImage.loadFrom(imageUrl)
        }
        nameLabel.text = business.name
        
        var addressString = String()
        if let address = business.location?.display_address {
            for addressLine in address {
                addressString.append("\(addressLine)\n")
            }
        }
        addressLabel.text = addressString
        
        var ratingString = "⭐️"
        if let rating = business.rating {
            ratingString.append(String(format: "%.2f", rating))
        }
        
        ratingLabel.text = ratingString
        priceLabel.text = business.price
    }
    
    func setup() {
        contentView.addSubview(businessImage)
        detailsSection.addArrangedSubview(nameLabel)
        detailsSection.addArrangedSubview(addressLabel)
        contentView.addSubview(detailsSection)
        ratingAndPriceSection.addArrangedSubview(ratingLabel)
        ratingAndPriceSection.addArrangedSubview(priceLabel)
        contentView.addSubview(ratingAndPriceSection)
        
        setBusinessImageConstraints()
        setDetailsSectionConstraints()
        setRatingAndPriceSectionConstraints()
    }
    
    private func setBusinessImageConstraints() {
        businessImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            businessImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            businessImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            businessImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            businessImage.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setDetailsSectionConstraints() {
        detailsSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsSection.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 10),
            detailsSection.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setRatingAndPriceSectionConstraints() {
        ratingAndPriceSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingAndPriceSection.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            ratingAndPriceSection.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
