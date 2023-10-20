//
//  Aggregates.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - AggregatesResponse
public struct AggregatesResponse: Codable, Sendable, Equatable {
    public let adjusted: Bool
    public let nextURL: String
    public let queryCount: Int
    public let requestID: String
    public let results: [AggregatesResult]
    public let resultsCount: Int
    public let status, ticker: String

    enum CodingKeys: String, CodingKey {
        case adjusted
        case nextURL = "next_url"
        case queryCount
        case requestID = "request_id"
        case results, resultsCount, status, ticker
    }
}

// MARK: - AggregatesResult
public struct AggregatesResult: Codable, Sendable, Equatable {
    public let close: Double
    public let high: Double
    public let low: Double
    public let transactions: Int
    public let open: Double
    public let timestamp: Date
    public let volume: Int
    public let averagePrice: Double
    
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
public struct AggregatesRequest {
    public let ticker: String
    public let multiplier: Int
    public let timespan: AggregateTimespan
    public let from: Date
    public let to: Date
    public let limit: Int
    public let sort: AggregateSort
    
    public init(ticker: String,
                multiplier: Int = 1,
                timespan: AggregateTimespan = .day,
                from: Date = Date(),
                to: Date = Date(),
                limit: Int = 5000,
                sort: AggregateSort = .desc) {
        self.ticker = ticker
        self.multiplier = multiplier
        self.timespan = timespan
        self.from = from
        self.to = to
        self.limit = limit
        self.sort = sort
    }
}
