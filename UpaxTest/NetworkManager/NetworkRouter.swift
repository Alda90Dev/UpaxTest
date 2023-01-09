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
    
    private static let baseURLString = "https://dummyjson.com"
    
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
        }
    }
    
    private var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getComments:
            return "/comments"
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(NetworkRouter.baseURLString)\(path)"
        
        guard let baseURL = URL(string: urlString)
                else { throw NetworkErrorType.parseUrlFail }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
