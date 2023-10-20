//
//  Timespan.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

// MARK: - AggregateTimespan
public enum AggregateTimespan: String, CaseIterable, Sendable {
    case second
    case minute
    case hour
    case day
    case week
    case month
    case quarter
    case year
}

// MARK: - AggregateSort
public enum AggregateSort: String, CaseIterable {
    case asc
    case desc
}

// MARK: - HttpMethod
public enum HttpMethod: String {
    case get
    case put
    case post
    case delete
}
