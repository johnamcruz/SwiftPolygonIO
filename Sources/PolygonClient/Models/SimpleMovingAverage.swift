//
//  SimpleMovingAverage.swift
//  
//
//  Created by John M Cruz on 10/21/23.
//

import Foundation

// MARK: - SimpleMovingAverage
public struct SimpleMovingAverage: Codable, Equatable {
    public let results: SimpleMovingAverageResults
    public let status, requestID: String
    public let nextURL: String?

    enum CodingKeys: String, CodingKey {
        case results, status
        case requestID = "request_id"
        case nextURL = "next_url"
    }
}

// MARK: - Results
public struct SimpleMovingAverageResults: Codable, Equatable {
    public let underlying: UnderlyingUrl
    public let values: [SimpleMovingAverageValue]
}

// MARK: - UnderlyingUrl
public struct UnderlyingUrl: Codable,Equatable {
    public let url: String
}

// MARK: - SimpleMovingAverageValue
public struct SimpleMovingAverageValue: Codable, Equatable {
    public let timestamp: Date
    public let value: Double
}
