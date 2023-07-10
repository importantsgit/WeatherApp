//
//  Forecast.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import Foundation

struct Forecast: Identifiable {
    var id = UUID()
    
    let date: String
    let time: String
    let icon: String
    let day: String
    let temperature: String
    let feelsLike: String
    let humidity: String
    let description: String
    let forecastDate: Date
}

extension Forecast {
    static var preview: [Forecast] {
        return (0..<10).map {
            let dt = Date.now.addingTimeInterval(TimeInterval($0 * 3600 * 24))
            
            return Forecast(date: dt.formatted(Date.FormatStyle.dateTime.month().hour()), time: dt.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute()), icon: "01d",day: "일", temperature: Double.randomTemperatureString, feelsLike: Double.randomTemperatureString ,humidity: Double.randomTemperatureString ,description: "Happy", forecastDate: .now)
        }
    }
    
    init?(forecastdata: CodableForecast.ListItem) {
        let dt = Date(timeIntervalSince1970: TimeInterval(forecastdata.dt))
        
        date = dt.formatted(Date.FormatStyle.dateTime.month().day())
        time = dt.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        day = dt.formatted(Date.FormatStyle.dateTime.weekday())
        
        guard let weatherData = forecastdata.weather.first else { return nil }
        
        icon = weatherData.icon
        
        temperature = forecastdata.main.temp.temperatureString
        
        feelsLike = forecastdata.main.feelsLike.temperatureString
        humidity = "\(forecastdata.main.humidity)%"
        
        description = weatherData.description
        
        forecastDate = Date(timeIntervalSince1970: TimeInterval(forecastdata.dt))
    }
}
