//
//  Timespan.swift
//
//
//  Created by John M Cruz on 10/19/23.
//

import Foundation

public enum Timespan: String, CaseIterable, Sendable {
    case second
    case minute
    case hour
    case day
    case week
    case month
    case quarter
    case year
}
