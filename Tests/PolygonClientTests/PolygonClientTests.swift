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
}
