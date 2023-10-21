//
//  Ticker.swift
//
//
//  Created by John M Cruz on 10/20/23.
//

import Foundation

// MARK: - Ticker
public struct Ticker: Codable, Equatable {
    public let results: [TickerResult]
    public let status, requestID: String
    public let count: Int

    enum CodingKeys: String, CodingKey {
        case results, status
        case requestID = "request_id"
        case count
    }
}

// MARK: - TickerResult
public struct TickerResult: Codable, Equatable {
    public let ticker, name, market, locale: String
    public let primaryExchange, type: String
    public let active: Bool
    public let currencyName, cik, compositeFigi, shareClassFigi: String
    public let lastUpdatedUTC: String //todo: replace to date

    enum CodingKeys: String, CodingKey {
        case ticker, name, market, locale
        case primaryExchange = "primary_exchange"
        case type, active
        case currencyName = "currency_name"
        case cik
        case compositeFigi = "composite_figi"
        case shareClassFigi = "share_class_figi"
        case lastUpdatedUTC = "last_updated_utc"
    }
}

