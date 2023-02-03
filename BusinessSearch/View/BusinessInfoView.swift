//
//  BusinessInfoView.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class BusinessInfoView: UIView {

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
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.text = "Business Address"
        addressLabel.font = UIFont.systemFont(ofSize: 18)
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    
    private lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = "(000) 000-0000"
        phoneLabel.font = UIFont.systemFont(ofSize: 18)
        return phoneLabel
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Category"
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.numberOfLines = 0
        return categoryLabel
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
        ratingLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return ratingLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return priceLabel
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
    func configure(with business: Business?) {
        guard let business = business else { return }
        
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
        phoneLabel.text = business.display_phone
        
        var categoryString = "Categories:\n"
        if let categories = business.categories {
            for category in categories {
                categoryString.append("- \(category.title!)\n")
            }
        }
        categoryLabel.text = categoryString
        
        var ratingString = "⭐️"
        if let rating = business.rating {
            ratingString.append(String(format: "%.2f", rating))
        }
        
        if let reviewCount = business.review_count {
            ratingString.append(" (\(reviewCount))")
        }
        
        ratingLabel.text = ratingString
        priceLabel.text = business.price
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(businessImage)
        detailsSection.addArrangedSubview(nameLabel)
        detailsSection.addArrangedSubview(addressLabel)
        detailsSection.addArrangedSubview(phoneLabel)
        detailsSection.addArrangedSubview(categoryLabel)
        addSubview(detailsSection)
        ratingAndPriceSection.addArrangedSubview(ratingLabel)
        ratingAndPriceSection.addArrangedSubview(priceLabel)
        addSubview(ratingAndPriceSection)
        
        setConstraints()
    }
    
    private func setConstraints() {
        setBusinessImageConstraints()
        setDetailsSectionConstraints()
        setRatingAndPriceSectionConstraints()
    }
    
    private func setBusinessImageConstraints() {
        businessImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            businessImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            businessImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            businessImage.topAnchor.constraint(equalTo: self.topAnchor),
            businessImage.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setDetailsSectionConstraints() {
        detailsSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsSection.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 10),
            detailsSection.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setRatingAndPriceSectionConstraints() {
        ratingAndPriceSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingAndPriceSection.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 10),
            ratingAndPriceSection.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
