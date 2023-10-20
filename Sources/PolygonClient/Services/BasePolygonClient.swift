//
//  BasePolygonClient.swift
//  
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(iOS 15, macOS 12.0, *)
protocol APIClient {
    func send<Response: Codable>(request: URLRequest) async throws -> Response?
}

@available(macOS 12.0, *)
class BasePolygonClient: APIClient {
    let baseUrl: URL = URL(string: "https://api.polygon.io")!
    let transport: HttpTransport
    
    init(transport: HttpTransport) {
        self.transport = transport
    }
    
    func send<Response: Codable>(request: URLRequest) async throws -> Response {
        try await self.transport.send(request: request) as Response
    }
}
