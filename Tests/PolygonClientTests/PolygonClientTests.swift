import XCTest
@testable import PolygonClient

@available(iOS 17, macOS 14.0, *)
final class PolygonClientTests: XCTestCase {
    private let getAggregates = "get-aggregates.json"
    private let getGroupDaily = "get-groupdaily.json"
    private let getTicker = "get-ticker.json"
    private let getTickerDetails = "get-ticker-details.json"
    private let getSimpleMovingAverage = "get-sma.json"
    private let getExponentialMovingAverage = "get-ema.json"
    private let getRelativeStrength = "get-rsi.json"
    private let getDailyOpenClose = "get-daily-openclose.json"
    private let dateFormatStyle = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    
    func testGetAggregates() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(AggregatesResponse.self, from: getAggregates)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        let request = AggregatesRequest(ticker: "AAPL", multiplier: 1, from: Date(), to: Date())
        let response = try await client.getAggregates(request: request)
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetGroupDaily() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(GroupedDaily.self, from: getGroupDaily)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getGroupDaily(date: Date())
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetTicker() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(Ticker.self, from: getTicker)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getTicker(query: "AAPL", order: .asc)
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetTickerDetails() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(TickerDetails.self, from: getTickerDetails)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getTickerDetails(ticker: "AAPL")
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetSimpleMovingAverage() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(SimpleMovingAverage.self, from: getSimpleMovingAverage)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getSimpleMovingAverage(ticker: "AAPL", date: Date(), timespan: .day)
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetExponentialMovingAverage() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(ExponentialMovingAverage.self, from: getExponentialMovingAverage)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getExponentialMovingAverage(ticker: "AAPL", date: Date(), timespan: .day)
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetRelativeStrengthIndex() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(RelativeStrengthIndex.self, from: getRelativeStrength)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getRelativeStrengthIndex(ticker: "AAPL", date: Date(), timespan: .day)
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetDailyOpenClose() async throws {
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(DailyOpenClose.self, from: getDailyOpenClose)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(transport: transport)
        
        let response = try await client.getDailyOpenClose(ticker: "AAPL", date: Date())
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetTickerUrl() throws {
        let transport = MockHttpTransport()
        let client = PolygonClient(transport: transport)
        
        if let url = try client.getTickerUrl(order: .asc) {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v3/reference/tickers?market=stocks&active=true&order=asc")
        } else {
            XCTFail("Failed to parse data")
        }
        
        if let url = try client.getTickerUrl(query: "AAPLE", order: .asc) {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v3/reference/tickers?market=stocks&active=true&search=AAPLE&order=asc")
        } else {
            XCTFail("Failed to parse data")
        }
        
        if let url = try client.getTickerUrl(ticker: "AAPL", query: "AAPLE", order: .asc) {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v3/reference/tickers?ticker=AAPL&market=stocks&active=true&search=AAPLE&order=asc")
        } else {
            XCTFail("Failed to parse data")
        }
    }
    
    func testGetSimpleMovingAverageUrl() throws {
        let transport = MockHttpTransport()
        let client = PolygonClient(transport: transport)
        
        if let url = try client.getSimpleMovingAverageUrl(ticker: "AAPL") {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v1/indicators/sma/AAPL?timespan=day&window=50")
        } else {
            XCTFail("Failed to parse data")
        }
    }
    
    func testGetExponentialMovingAverage() throws {
        let transport = MockHttpTransport()
        let client = PolygonClient(transport: transport)
        
        if let url = try client.getExponentialMovingAverageUrl(ticker: "AAPL") {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v1/indicators/ema/AAPL?timespan=day&window=50")
        } else {
            XCTFail("Failed to parse data")
        }
    }
    
    func testGetRelativeStrengthIndex() throws {
        let transport = MockHttpTransport()
        let client = PolygonClient(transport: transport)
        
        if let url = try client.getRelativeStrengthIndexUrl(ticker: "AAPL") {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v1/indicators/rsi/AAPL?timespan=day&window=50")
        } else {
            XCTFail("Failed to parse data")
        }
    }
    
    func testGetAggregatesUrl() throws {
        let transport = MockHttpTransport()
        let client = PolygonClient(transport: transport)
        
        let date = Date().formatted(dateFormatStyle)
        if let url = try client.getAggregatesUrl(request: AggregatesRequest(ticker: "AAPL", from: Date(), to: Date())) {
            XCTAssertEqual(url.absoluteString,
                           "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/\(date)/\(date)?sort=desc&limit=5000")
        } else {
            XCTFail("Failed to parse data")
        }
    }
}
