//
//  PostResponse.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

// MARK: - PostResponse
struct PostResponse: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let title, body: String
    let userID: Int
    let tags: [String]
    let reactions: Int

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case userID = "userId"
        case tags, reactions
    }
    
    func getTags() -> String {
        let tags = tags.map { $0 }.joined(separator: ",")
        return tags
    }
}
