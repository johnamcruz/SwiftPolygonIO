//
//  RelativeStrengthIndex.swift
//  
//
//  Created by John M Cruz on 10/21/23.
//

// MARK: - RelativeStrengthIndex
public struct RelativeStrengthIndex: Codable, Equatable, Sendable {
    public let results: Results
    public let status, requestID: String
    public let nextURL: String?

    enum CodingKeys: String, CodingKey {
        case results, status
        case requestID = "request_id"
        case nextURL = "next_url"
    }
}
