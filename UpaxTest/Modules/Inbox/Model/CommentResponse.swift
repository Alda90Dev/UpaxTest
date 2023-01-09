//
//  CommentResponse.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let comments: [Comment]
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let body: String
    let postID: Int
    let user: UserComment

    enum CodingKeys: String, CodingKey {
        case id, body
        case postID = "postId"
        case user
    }
}

// MARK: - UserComment
struct UserComment: Codable {
    let id: Int
    let username: String
}
