//
//  GroupedDaily.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - GroupedDaily
struct GroupedDaily: Codable, Sendable {
    let adjusted: Bool
    let queryCount: Int
    let results: [GroupedDailyResult]
    let resultsCount: Int
    let status: String
}

// MARK: - Result
struct GroupedDailyResult: Codable, Sendable {
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
