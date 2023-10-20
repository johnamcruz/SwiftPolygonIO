//
//  PolygonClient.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

enum PolygonClientError: Error {
    case urlParsingError
    case urlBuildingError
}

@available(iOS 17, macOS 14.0, *)
final class PolygonClient: BasePolygonClient  {
    private let dateFormatStyle = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    
    // /v2/aggs/ticker/{stocksTicker}/range/{multiplier}/{timespan}/{from}/{to}
    // https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/minute/2023-01-09/2023-01-09?adjusted=true&sort=asc&limit=120
    func getAggregates(request: AggregatesRequest) async throws -> AggregatesResponse {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let from = request.from.formatted(dateFormatStyle)
        let to = request.to.formatted(dateFormatStyle)
        component.path = "/v2/aggs/ticker/\(request.ticker)/range/\(request.multiplier)/\(request.timespan.rawValue)/\(from)/\(to)"
        component.queryItems = [
            URLQueryItem(name: "sort", value: request.sort.rawValue),
            URLQueryItem(name: "limit", value: String(request.limit))
        ]
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: URLRequest(url: updatedUrl))
    }
    
    // /v2/aggs/grouped/locale/us/market/stocks/{date}
    // https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-01-09?adjusted=true
    func getGroupDaily(date: Date) async throws -> GroupedDaily {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let date = date.formatted(dateFormatStyle)
        component.path = "/v2/aggs/grouped/locale/us/market/stocks/\(date)"
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: URLRequest(url: updatedUrl))
    }
}
