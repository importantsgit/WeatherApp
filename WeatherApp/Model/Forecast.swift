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
    let weather: String
    let temperature: String
    let minTemperature: String
    let maxTemperature: String
    let forecastedDate: Date
}

extension Forecast {
    static var preview: [Forecast] {
        return (0..<10).map {
            let dt = Date.now.addingTimeInterval(TimeInterval($0 * 3600 * 24))
            
            return Forecast(date: dt.formatted(Date.FormatStyle.dateTime.month().hour()), time: dt.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute()), icon: "01d", weather: "맑음", temperature: Double.randomTemperatureString, minTemperature: Double.randomTemperatureString, maxTemperature: Double.randomTemperatureString, forecastedDate: .now)
        }
    }
}
