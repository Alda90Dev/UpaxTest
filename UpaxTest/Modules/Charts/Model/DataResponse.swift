//
//  DataResponse.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

// MARK: - DataResponse
struct DataResponse: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let pregunta: String
    let values: [Value]
}

// MARK: - Value
struct Value: Codable {
    let label: String
    let value: Int
}
