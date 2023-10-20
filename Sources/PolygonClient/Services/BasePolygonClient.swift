//
//  BasePolygonClient.swift
//  
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(macOS 12.0, *)
protocol APIClient {
    func send<Response: Codable>(request: URLRequest) async throws -> Response?
}

@available(macOS 12.0, *)
class BasePolygonClient: APIClient {
    let baseUrl: URL
    let transport: HttpTransport
    
    init(baseUrl: URL, transport: HttpTransport) {
        self.baseUrl = baseUrl
        self.transport = transport
    }
    
    func send<Response: Codable>(request: URLRequest) async throws -> Response {
        try await self.transport.send(request: request) as Response
    }
}
