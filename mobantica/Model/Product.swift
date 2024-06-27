//
//  Product.swift
//  mobantica
//
//  Created by apple on 26/06/24.
//

import Foundation

//MARK: Model for data fetch 
struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let category: String
    let images: [String]
    let thumbnail: String
    let reviews: [Review]
    let rating : Double
    let returnPolicy : String
}

struct ProductResponse: Codable {
    let products: [Product]
}

struct Review: Codable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}
