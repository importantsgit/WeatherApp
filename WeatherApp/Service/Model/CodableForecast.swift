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
    let feelsLike: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let icon: String
    let description: String
}
