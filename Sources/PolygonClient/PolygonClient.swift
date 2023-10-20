//
//  PolygonClient.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(macOS 12.0, *)
final class PolygonClient: BasePolygonClient  {
    // /v2/aggs/ticker/{stocksTicker}/range/{multiplier}/{timespan}/{from}/{to}
    // https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/minute/2023-01-09/2023-01-09?adjusted=true&sort=asc&limit=120
    func getAggregates(request: AggregatesRequest) async throws -> AggregatesResponse {
        var request = URLRequest(url: self.baseUrl)
        request.httpMethod = "GET"
        return try await send(request: request)
    }
    
    // /v2/aggs/grouped/locale/us/market/stocks/{date}
    // https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-01-09?adjusted=true
    func getGroupDaily(date: Date) async throws -> GroupedDaily {
        try await send(request: URLRequest(url: self.baseUrl))
    }
}
