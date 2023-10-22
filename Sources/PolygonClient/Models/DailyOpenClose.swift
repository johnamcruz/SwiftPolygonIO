//
//  DailyOpenClose.swift
//
//
//  Created by John M Cruz on 10/21/23.
//

import Foundation

// MARK: - DailyOpenClose
public struct DailyOpenClose: Codable, Equatable, Sendable {
    public let status: String
    public let from: String
    public let symbol: String
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    public let volume: Int
    public let afterHours: Double
    public let preMarket: Double

    enum CodingKeys: String, CodingKey {
        case status, from, symbol
        case open
        case high, low, close, volume, afterHours, preMarket
    }
}
