//
//  ProductResponse.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    
    func thumbnailURL() -> URL? {
        guard let urlString = thumbnail,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func firstImageURL() -> URL? {
        guard let images = images,
              let urlString = images.first,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
}
