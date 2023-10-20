//
//  GroupedDaily.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - GroupedDaily
public struct GroupedDaily: Codable, Sendable, Equatable {
    public let adjusted: Bool
    public let queryCount: Int
    public let results: [GroupedDailyResult]
    public let resultsCount: Int
    public let status: String
}

// MARK: - Result
public struct GroupedDailyResult: Codable, Sendable, Equatable {
    public let ticker: String
    public let close: Double
    public let high: Double
    public let low: Double
    public let open: Double
    public let transactions: Int
    public let timestamp: Date
    public let volume: Double
    public let averagePrice: Double
    public let otc: Bool?

    enum CodingKeys: String, CodingKey {
        case ticker = "T"
        case close = "c"
        case high = "h"
        case low = "l"
        case open = "o"
        case transactions = "n"
        case volume = "v"
        case timestamp = "t"
        case averagePrice = "vw"
        case otc
    }
}
