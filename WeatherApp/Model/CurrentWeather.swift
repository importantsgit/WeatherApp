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
        guard let weatherInfo = weatherData.list.first,
              let pollutionInfo = pollutionData.list.first?.main.description else { return nil }
        
        icon = weatherInfo.icon
        weather = weatherInfo.description
        temperature = weatherData.current.temp.temperatureString
        feelsLike = weatherData.current.feelsLike.temperatureString
        humidity = "\(weatherData.current.humidity)"
        
        var date = Date(timeIntervalSince1970: TimeInterval(weatherData.current.sunrise!))
        sunrise = date.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        
        date = Date(timeIntervalSince1970: TimeInterval(weatherData.current.sunset!))
        sunset = date.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        
        airPollution = pollutionInfo
        
        forecastedDate = Date(timeIntervalSince1970: TimeInterval(weatherData.current.dt))
        description = weatherInfo.description
    }
}
