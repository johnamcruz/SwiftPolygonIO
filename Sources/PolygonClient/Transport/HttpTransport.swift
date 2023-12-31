//
//  HttpTransport.swift
//  
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

public protocol HttpTransport {
    var headers: [String: String] { get set }
    var decoder: JSONDecoder { get set }
    func send<Response: Codable>(request: URLRequest) async throws -> Response
}
