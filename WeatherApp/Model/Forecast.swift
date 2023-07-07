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
}

extension Forecast {
    static var preview: [Forecast] {
        return (0..<10).map {
            let dt = Date.now.addingTimeInterval(TimeInterval($0 * 3600 * 24))
            
            return Forecast(date: dt.formatted(Date.FormatStyle.dateTime.month().hour()), time: dt.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute()), icon: "01d",day: "일", temperature: Double.randomTemperatureString)
        }
    }
    
    init?(data: CodableForecast.ListItem) {
        let dt = Date(timeIntervalSince1970: TimeInterval(data.dt))
        
        date = dt.formatted(Date.FormatStyle.dateTime.month().day())
        time = dt.formatted(Date.FormatStyle.dateTime.hour(.twoDigits(amPM: .omitted)).minute())
        day = dt.formatted(Date.FormatStyle.dateTime.weekday())
        
        guard let weatherData = data.weather.first else { return nil }
        
        icon = weatherData.icon
        
        temperature = data.main.temp.temperatureString
    }
}
