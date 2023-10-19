//
//  Aggregates.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - Aggregates
struct Aggregates: Codable, Sendable {
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

// MARK: - Result
struct AggregatesResult: Codable, Sendable {
    let c, h, l: Double
    let n: Int
    let o: Double
    let t, v: Int
    let vw: Double
}
