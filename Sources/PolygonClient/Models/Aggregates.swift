//
//  Aggregates.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - AggregatesResponse
struct AggregatesResponse: Codable, Sendable, Equatable {
    let adjusted: Bool
    let nextURL: String
    let queryCount: Int
    let requestID: String
    let results: [AggregatesResult]
    let resultsCount: Int
    let status, ticker: String

    enum CodingKeys: String, CodingKey {
        case adjusted
        case nextURL = "next_url"
        case queryCount
        case requestID = "request_id"
        case results, resultsCount, status, ticker
    }
}

// MARK: - AggregatesResult
struct AggregatesResult: Codable, Sendable, Equatable {
    let close: Double
    let high: Double
    let low: Double
    let transactions: Int
    let open: Double
    let timestamp: Date
    let volume: Int
    let averagePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case close = "c"
        case open = "o"
        case high = "h"
        case low = "l"
        case transactions = "n"
        case timestamp = "t"
        case volume = "v"
        case averagePrice = "vw"
    }
}

// MARK: - AggregatesRequest
struct AggregatesRequest {
    let ticker: String
    var multiplier: Int = 1
    var timespan: AggregateTimespan = .day
    var from: Date = Date()
    var to: Date = Date()
    var limit: Int = 120
    var sort: AggregateSort = .desc
}
