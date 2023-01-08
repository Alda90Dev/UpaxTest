//
//  NetworkResult.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

enum NetworkResult<T> {
    case success(data: T)
    case failure(error: Error)
}

enum NetworkErrorType: LocalizedError {
    case parseUrlFail
    case invalidResponse
    case dataError
    case serverError
    case customizedError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object"
        case .invalidResponse:
            return "Invalid Response"
        case .dataError:
            return "Invalid data"
        case .serverError:
            return "Internal Server Error"
        case .customizedError(let message):
            return message
        }
    }
}

