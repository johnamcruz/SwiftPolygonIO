//
//  UrlSessionTransport.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(macOS 12.0, *)
class UrlSessionTransport: HttpTransport {
    private let session: URLSession
    internal var header: [String : String] = [:]
    private let decoder: JSONDecoder
    
    
    init(session: URLSession = URLSession.shared, 
         header: [String : String] = [:],
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.header = header
        self.decoder = decoder
    }
    
    func send<Response: Codable>(request: URLRequest) async throws -> Response {
        let (data,_) = try await self.session.data(for: request)
        return try decoder.decode(Response.self, from: data)
    }
    
}
