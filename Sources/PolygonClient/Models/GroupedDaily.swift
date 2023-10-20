//
//  GroupedDaily.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - GroupedDaily
public struct GroupedDaily: Codable, Sendable, Equatable {
    public let adjusted: Bool
    public let queryCount: Int
    public let results: [GroupedDailyResult]
    public let resultsCount: Int
    public let status: String
}

// MARK: - Result
public struct GroupedDailyResult: Codable, Sendable, Equatable {
    public let t: String
    public let c, h, l: Double
    public let n: Int
    public let o: Double
    public let resultT: Int
    public let v, vw: Double

    enum CodingKeys: String, CodingKey {
        case t = "T"
        case c, h, l, n, o
        case resultT = "t"
        case v, vw
    }
}
