//
//  HttpTransport.swift
//  
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

public protocol HttpTransport {
    var header: [String: String] { get set }
    func send<Response: Codable>(request: URLRequest) async throws -> Response
}
