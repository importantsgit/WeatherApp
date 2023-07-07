//
//  CodableCurrentAirPollution.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation

struct CodableCurrentAirPollution: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let aqi: Int
}


// 1 = Good
// 2 = Fair
// 3 = Moderate
// 4 = Poor
// 5 = Very Poor
