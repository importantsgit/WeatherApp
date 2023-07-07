//
//  CodableForecast.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import Foundation

// MARK: - CodableForecast
struct CodableForecast: Codable {
    struct ListItem: Codable {
        let dt: Int
        let main: MainForecast
        let weather: [ForecastWeather]
    }
    
    let list: [ListItem]
}

// MARK: - Main
struct MainForecast: Codable {
    let temp: Double
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let icon: String
}
