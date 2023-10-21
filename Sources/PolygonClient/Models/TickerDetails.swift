//
//  TickerDetails.swift
//
//
//  Created by John M Cruz on 10/20/23.
//

import Foundation

// MARK: - Ticker
public struct TickerDetails: Codable, Equatable {
    public let requestID: String
    public let results: TickerDetailsResults
    public let status: String

    enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
        case results, status
    }
}

// MARK: - TickerDetailsResults
public struct TickerDetailsResults: Codable, Equatable {
    public let ticker, name, market, locale: String
    public let primaryExchange, type: String
    public let active: Bool
    public let currencyName, cik, compositeFigi, shareClassFigi: String
    public let marketCap: Int
    public let phoneNumber: String
    public let address: Address
    public let description, sicCode, sicDescription, tickerRoot: String
    public let homepageURL: String
    public let totalEmployees: Int
    public let listDate: String
    public let branding: Branding
    public let shareClassSharesOutstanding, weightedSharesOutstanding, roundLot: Int

    enum CodingKeys: String, CodingKey {
        case ticker, name, market, locale
        case primaryExchange = "primary_exchange"
        case type, active
        case currencyName = "currency_name"
        case cik
        case compositeFigi = "composite_figi"
        case shareClassFigi = "share_class_figi"
        case marketCap = "market_cap"
        case phoneNumber = "phone_number"
        case address, description
        case sicCode = "sic_code"
        case sicDescription = "sic_description"
        case tickerRoot = "ticker_root"
        case homepageURL = "homepage_url"
        case totalEmployees = "total_employees"
        case listDate = "list_date"
        case branding
        case shareClassSharesOutstanding = "share_class_shares_outstanding"
        case weightedSharesOutstanding = "weighted_shares_outstanding"
        case roundLot = "round_lot"
    }
}

// MARK: - Address
public struct Address: Codable, Equatable {
    public let address1, city, state, postalCode: String

    enum CodingKeys: String, CodingKey {
        case address1, city, state
        case postalCode = "postal_code"
    }
}

// MARK: - Branding
public struct Branding: Codable, Equatable {
    public let logoURL: String
    public let iconURL: String

    enum CodingKeys: String, CodingKey {
        case logoURL = "logo_url"
        case iconURL = "icon_url"
    }
}

