//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import Foundation

struct CurrentWeather {
    let icon: String
    let weather :String
    let temperature: String
    let sunrise: String
    let sunset: String
    let feelsLike: String
    let humidity: String
    let airPollution: String
    let forecastedDate: Date
    let description: String
}

extension CurrentWeather {
    static var preview: CurrentWeather {
        return CurrentWeather(icon: "01d", weather: "맑음", temperature: Double.randomTemperatureString, sunrise: "6:00", sunset: "6:00", feelsLike: Double.randomTemperatureString, humidity: Double.randomTemperatureString, airPollution: "Good", forecastedDate: .now,
                              description: "light rain"
        )
    }
    
    init?(weatherData: CodableCurrentWeather, pollutionData: CodableCurrentAirPollution) {
        guard let weatherInfo = weatherData.weather.first,
              let pollutionLevel = pollutionData.list.first else { return nil }
        
        icon = weatherInfo.icon
        weather = weatherInfo.description
        temperature = weatherData.main.temp.temperatureString
        feelsLike = weatherData.main.feelsLike.temperatureString
        humidity = "\(weatherData.main.humidity)%"
        
        var date = Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunrise))
        sunrise = date.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        
        date = Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunset))
        sunset = date.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        
        var str = ""
        switch pollutionLevel.main.aqi {
        case 1: str = "Good"
        case 2: str = "Fair"
        case 3: str = "Moderate"
        case 4: str = "Poor"
        default: str = "Very Poor"
        }

        airPollution = str
        
        forecastedDate = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
        description = weatherInfo.description
    }
}
