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
public final class PolygonClient: BasePolygonClient  {
    private let dateFormatStyle = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    
    // /v2/aggs/ticker/{stocksTicker}/range/{multiplier}/{timespan}/{from}/{to}
    // https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/minute/2023-01-09/2023-01-09?adjusted=true&sort=asc&limit=120
    public func getAggregates(request: AggregatesRequest) async throws -> AggregatesResponse {
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
    public func getGroupDaily(date: Date) async throws -> GroupedDaily {
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
    
    //https://api.polygon.io/v3/reference/tickers?ticker=AAPL&market=stocks&active=true&apiKey=7XimeqW7DG_ozmE90Li_z90Nrc_pB6kn
    public func getTicker(ticker: String = "", query: String, order: AggregateSort) async throws -> Ticker {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        component.path = "/v3/reference/tickers"
        component.queryItems = [
            URLQueryItem(name: "ticker", value: ticker),
            URLQueryItem(name: "market", value: "stocks"),
            URLQueryItem(name: "active", value: "true"),
            URLQueryItem(name: "search", value: query),
            URLQueryItem(name: "order", value: order.rawValue),
        ]
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: URLRequest(url: updatedUrl))
    }
    
    public func getTickerDetails(ticker: String) async throws -> TickerDetails {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        component.path = "/v3/reference/tickers/\(ticker)"
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: URLRequest(url: updatedUrl))
    }
    
    public func getSimpleMovingAverage(ticker: String, timespan: AggregateTimespan) async throws -> SimpleMovingAverage {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        component.path = "/v1/indicators/sma/\(ticker)"
        component.queryItems = [
            URLQueryItem(name: "timespan", value: timespan.rawValue)
        ]
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: URLRequest(url: updatedUrl))
    }
}
