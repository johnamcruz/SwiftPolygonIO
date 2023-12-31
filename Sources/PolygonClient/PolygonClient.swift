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
        guard let updatedUrl = try getAggregatesUrl(request: request) else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
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
        return try await send(request: request)
    }
    
    //https://api.polygon.io/v3/reference/tickers?ticker=AAPL&market=stocks&active=true
    public func getTicker(ticker: String? = nil, query: String? = nil, order: AggregateSort) async throws -> Ticker {
        guard let updatedUrl = try getTickerUrl(ticker: ticker, query: query, order: order) else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
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
        return try await send(request: request)
    }
    
    public func getSimpleMovingAverage(ticker: String, 
                                       date: Date? = nil,
                                       timespan: AggregateTimespan = .day,
                                       window: Int = 50,
                                       cursor: String? = nil) async throws -> SimpleMovingAverage {
        
        guard let updatedUrl = try getSimpleMovingAverageUrl(ticker: ticker,
                                                         date: date,
                                                         timespan: timespan,
                                                         window: window,
                                                         cursor: cursor) else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
    }
    
    public func getExponentialMovingAverage(ticker: String,
                                            date: Date? = nil,
                                            timespan: AggregateTimespan = .day,
                                            window: Int = 50,
                                            cursor: String? = nil) async throws -> ExponentialMovingAverage {
        
        guard let updatedUrl = try getExponentialMovingAverageUrl(ticker: ticker,
                                                              date: date,
                                                              timespan: timespan,
                                                              window: window,
                                                              cursor: cursor) else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
    }
    
    public func getRelativeStrengthIndex(ticker: String,
                                         date: Date? = nil,
                                         timespan: AggregateTimespan = .day,
                                         window: Int = 50,
                                         cursor: String? = nil) async throws -> RelativeStrengthIndex {
        
        guard let updatedUrl = try getRelativeStrengthIndexUrl(ticker: ticker,
                                                           date: date,
                                                           timespan: timespan,
                                                           window: window,
                                                           cursor: cursor) else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
    }
    
    public func getDailyOpenClose(ticker: String, date: Date) async throws -> DailyOpenClose {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let date = date.formatted(dateFormatStyle)
        component.path = "/v1/open-close/\(ticker)/\(date)"
        guard let updatedUrl = component.url else {
            throw PolygonClientError.urlBuildingError
        }
        print(updatedUrl.absoluteString)
        var request = URLRequest(url: updatedUrl)
        request.httpMethod = HttpMethod.get.rawValue.uppercased()
        return try await send(request: request)
    }
    
    func getAggregatesUrl(request: AggregatesRequest) throws -> URL? {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let from = request.from.formatted(dateFormatStyle)
        let to = request.to.formatted(dateFormatStyle)
        component.path = "/v2/aggs/ticker/\(request.ticker)/range/\(request.multiplier)/\(request.timespan.rawValue)/\(from)/\(to)"
        component.queryItems = [
            URLQueryItem(name: "sort", value: request.sort.rawValue),
            URLQueryItem(name: "limit", value: String(request.limit))
        ].filter{ $0.value != nil }
        
        return component.url
    }
    
    func getTickerUrl(ticker: String? = nil, query: String? = nil, order: AggregateSort) throws -> URL? {
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
        ].filter{ $0.value != nil }
        
        return component.url
    }
    
    func getSimpleMovingAverageUrl(ticker: String,
                                       date: Date? = nil,
                                       timespan: AggregateTimespan = .day,
                                       window: Int = 50,
                                cursor: String? = nil) throws -> URL? {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let date = date?.formatted(dateFormatStyle)
        
        component.path = "/v1/indicators/sma/\(ticker)"
        component.queryItems = [
            URLQueryItem(name: "timestamp", value: date),
            URLQueryItem(name: "timespan", value: timespan.rawValue),
            URLQueryItem(name: "window", value: String(window)),
            URLQueryItem(name: "cursor", value: cursor)
        ].filter{ $0.value != nil }
        
        return component.url
    }
    
    func getExponentialMovingAverageUrl(ticker: String,
                                            date: Date? = nil,
                                            timespan: AggregateTimespan = .day,
                                            window: Int = 50,
                                     cursor: String? = nil) throws -> URL? {
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let date = date?.formatted(dateFormatStyle)
        
        component.path = "/v1/indicators/ema/\(ticker)"
        component.queryItems = [
            URLQueryItem(name: "timestamp", value: date),
            URLQueryItem(name: "timespan", value: timespan.rawValue),
            URLQueryItem(name: "window", value: String(window)),
            URLQueryItem(name: "cursor", value: cursor)
        ].filter{ $0.value != nil }
        
        return component.url
    }
    
    func getRelativeStrengthIndexUrl(ticker: String,
                                         date: Date? = nil,
                                         timespan: AggregateTimespan = .day,
                                         window: Int = 50,
                                         cursor: String? = nil) throws -> URL? {
        
        guard var component = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PolygonClientError.urlParsingError
        }
        let date = date?.formatted(dateFormatStyle)
        
        component.path = "/v1/indicators/rsi/\(ticker)"
        component.queryItems = [
            URLQueryItem(name: "timestamp", value: date),
            URLQueryItem(name: "timespan", value: timespan.rawValue),
            URLQueryItem(name: "window", value: String(window)),
            URLQueryItem(name: "cursor", value: cursor)
        ].filter{ $0.value != nil }
        
        return component.url
    }
}
