//
//  MockHttpTransport.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation
import PolygonClient

enum MockHttpTransportError: Error {
    case responseValueNil
}

class MockHttpTransport: HttpTransport {
    var headers: [String : String] = [:]
    var responseValue: Data?
    internal var decoder: JSONDecoder = JSONDecoder()
    
    func send<Response: Codable>(request: URLRequest) async throws -> Response {
        guard let responseValue = responseValue else {
            throw MockHttpTransportError.responseValueNil
        }
        return try decoder.decode(Response.self, from: responseValue)
    }
}
