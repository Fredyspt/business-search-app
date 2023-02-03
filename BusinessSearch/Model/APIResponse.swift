//
//  Business.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import Foundation

struct APIResponse: Decodable {
    let businesses: Businesses?
}

struct Business: Decodable {
    let name: String?
    let image_url: String?
    let review_count: Int?
    let categories: [Category]?
    let rating: Double?
    let price: String?
    let location: Location?
    let display_phone: String?
}

struct Category: Decodable {
    let title: String?
}

struct Location: Decodable {
    let display_address: [String]?
}

typealias Businesses = [Business]
