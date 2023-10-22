//
//  SimpleMovingAverage.swift
//  
//
//  Created by John M Cruz on 10/21/23.
//

import Foundation

// MARK: - SimpleMovingAverage
public struct SimpleMovingAverage: Codable, Equatable, Sendable {
    public let results: Results
    public let status, requestID: String
    public let nextURL: String?

    enum CodingKeys: String, CodingKey {
        case results, status
        case requestID = "request_id"
        case nextURL = "next_url"
    }
}

// MARK: - Results
public struct Results: Codable, Equatable, Sendable {
    public let underlying: UnderlyingUrl
    public let values: [Value]
}

// MARK: - UnderlyingUrl
public struct UnderlyingUrl: Codable,Equatable, Sendable {
    public let url: String
}

// MARK: - Value
public struct Value: Codable, Equatable,Sendable {
    public let timestamp: Date
    public let value: Double
}
