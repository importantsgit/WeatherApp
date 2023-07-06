//
//  CodableCurrentAirPollution.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation

struct CodableCurrentAirPollution: Codable {
    let coord: [Int]
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
    
    var description: String {
        var str = ""
        switch aqi {
        case 1: str = "Good"
        case 2: str = "Fair"
        case 3: str = "Moderate"
        case 4: str = "Poor"
        default: str = "Very Poor"
        }
        return str
    }
}


// 1 = Good
// 2 = Fair
// 3 = Moderate
// 4 = Poor
// 5 = Very Poor
