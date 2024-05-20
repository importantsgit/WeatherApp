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
    
    let OPEN_WEATHER_API = "05b85b546ef44a9b508aed51de71a4ac"
    
    enum OPEN_WEATHER_URL: String {
        case CURRENT = "https://api.openweathermap.org/data/2.5/weather"
        case FORECAST = "https://api.openweathermap.org/data/2.5/forecast"
        case AIR_POLLUTION = "http://api.openweathermap.org/data/2.5/air_pollution"
    }
    
    enum PHOTO_URL: String {
        case LIST = "https://picsum.photos/v2/list"
    }
}
