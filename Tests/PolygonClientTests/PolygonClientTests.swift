import XCTest
@testable import PolygonClient

final class PolygonClientTests: XCTestCase {
    private let getAggregates = "get-aggregates.json"
    
    func testGetAggregates() async throws {
        guard let url = URL(string: "http://www.google.com") else {
            return
        }
        let transport = MockHttpTransport()
        let expectedResponse = Bundle.module.decode(Aggregates.self, from: getAggregates)
        transport.responseValue = try JSONEncoder().encode(expectedResponse)
        let client = PolygonClient(baseUrl: url, transport: transport)
        
        let response = try await client.getAggregates()
        print(response)
        XCTAssertEqual(expectedResponse, response)
    }
}
