//
//  CodableCurrentWeather.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation


// MARK: - Welcome
struct CodableCurrentWeather: Codable {
    let weather: [Weather]
    let main: MainCurrentWeather
    let dt: Int
    let sys: Sys
}

// MARK: - Main
struct MainCurrentWeather: Codable {
    let temp, feelsLike: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, sunset: Int
}

// MARK: - Welcome
struct CodableForeCast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeatherList]
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let sunrise, sunset: Int
}

// MARK: - List
struct WeatherList: Codable {
    let dt: Int
    let main: MainForcast
    let weather: [Weather]
}

// MARK: - Main
struct MainForcast: Codable {
    let temp, feelsLike: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
