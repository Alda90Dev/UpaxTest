//
//  NetworkRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

enum NetworkRouter {
    case getProducts
    case getComments
    case getPosts
    case getData
    
    private static let baseURLString = "https://dummyjson.com"
    private static let dataURLString = "https://s3.amazonaws.com/dev.reports.files"
    
    private enum HTTTPMethod {
        case get
        case post
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            }
        }
    }
    
    private var method: HTTTPMethod {
        switch self {
        case .getProducts: return .get
        case .getComments: return .get
        case .getPosts: return .get
        case .getData: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getComments:
            return "/comments"
        case .getPosts:
            return "/posts"
        case .getData:
            return "/test.json"
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = self == .getData ? "\(NetworkRouter.dataURLString)\(path)" : "\(NetworkRouter.baseURLString)\(path)"
        
        guard let baseURL = URL(string: urlString)
                else { throw NetworkErrorType.parseUrlFail }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
