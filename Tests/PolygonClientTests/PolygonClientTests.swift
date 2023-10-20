import XCTest
@testable import PolygonClient

@available(iOS 17, macOS 14.0, *)
final class PolygonClientTests: XCTestCase {
    private let getAggregates = "get-aggregates.json"
    private let getGroupDaily = "get-groupdaily.json"
    
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
}
