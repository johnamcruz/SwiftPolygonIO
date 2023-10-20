//
//  GroupedDaily.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - GroupedDaily
public struct GroupedDaily: Codable, Sendable, Equatable {
    let adjusted: Bool
    let queryCount: Int
    let results: [GroupedDailyResult]
    let resultsCount: Int
    let status: String
}

// MARK: - Result
public struct GroupedDailyResult: Codable, Sendable, Equatable {
    let t: String
    let c, h, l: Double
    let n: Int
    let o: Double
    let resultT: Int
    let v, vw: Double

    enum CodingKeys: String, CodingKey {
        case t = "T"
        case c, h, l, n, o
        case resultT = "t"
        case v, vw
    }
}
