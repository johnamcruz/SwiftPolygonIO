//
//  UrlSessionTransport.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(macOS 12.0, *)
public class UrlSessionTransport: HttpTransport {
    private let session: URLSession
    public var headers: [String : String] = [:]
    private let decoder: JSONDecoder
    
    
    public init(session: URLSession = URLSession.shared, 
         headers: [String : String] = [:],
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.headers = headers
        self.decoder = decoder
    }
    
    public init(session: URLSession = URLSession.shared, apiKey: String) {
        self.headers = ["Authorization":"Bearer \(apiKey)"]
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        self.decoder = decoder
        self.session = session
    }
    
    public func send<Response: Codable>(request: URLRequest) async throws -> Response {
        var request = request
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        let (data,_) = try await self.session.data(for: request)
        return try decoder.decode(Response.self, from: data)
    }
}
