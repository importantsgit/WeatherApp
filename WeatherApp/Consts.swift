//
//  Consts.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/26.
//

import Foundation

class Consts {
    static let shared = Consts()
    private init() {}
    
    let OPEN_WEATHER_API = "Push Your API"
    
    enum OPEN_WEATHER_URL: String {
        case CURRENT = "https://api.openweathermap.org/data/2.5/weather"
        case FORECAST = "https://api.openweathermap.org/data/2.5/forecast"
        case AIR_POLLUTION = "http://api.openweathermap.org/data/2.5/air_pollution"
    }
}
