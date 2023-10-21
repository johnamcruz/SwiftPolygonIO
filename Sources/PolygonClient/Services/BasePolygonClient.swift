//
//  BasePolygonClient.swift
//  
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(iOS 17, macOS 14.0, *)
protocol APIClient {
    func send<Response: Codable>(request: URLRequest) async throws -> Response
}

@available(iOS 17, macOS 14.0, *)
public class BasePolygonClient: APIClient {
    let baseUrl: URL = URL(string: "https://api.polygon.io")!
    var transport: HttpTransport
    
    public init(transport: HttpTransport) {
        self.transport = transport
    }
    
    public func send<Response: Codable>(request: URLRequest) async throws -> Response {
        try await self.transport.send(request: request) as Response
    }
}
