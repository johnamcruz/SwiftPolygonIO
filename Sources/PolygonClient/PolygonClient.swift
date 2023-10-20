//
//  PolygonClient.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

@available(macOS 12.0, *)
final class PolygonClient: BasePolygonClient  {
    func getAggregates() async throws -> Aggregates {
        try await send(request: URLRequest(url: self.baseUrl))
    }
}
