//
//  WidgetData.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation

struct WidgetData: Codable {
    let location: String
    let temperature: String
    let icon: String
    let weather: String
    let humidity: String
    let feelsLike: String
    let airPollution: String
    let date: Date
}

extension WidgetData {
    static let preview = WidgetData(location: "서울",
                                    temperature: Double.randomTemperatureString,
                                    icon: "10d",
                                    weather: "맑음",
                                    humidity: Double.randomTemperatureString,
                                    feelsLike: Double.randomTemperatureString,
                                    airPollution: "Good",
                                    date: .now)
    
    static let dataURL = FileManager.sharedContainerURL.appending(path: "WidgetData.json")
    
    static func write(location: String?, currentWeather: CurrentWeather?, forecast: [Forecast]?){
        guard let location = location,
              let currentWeather = currentWeather,
              let forecast = forecast
        else { return }
        
        var list = [WidgetData]()
        
        let data = WidgetData(location: location, temperature: currentWeather.temperature, icon: currentWeather.icon, weather: currentWeather.weather, humidity: currentWeather.humidity, feelsLike: currentWeather.feelsLike, airPollution: currentWeather.airPollution, date: currentWeather.forecastedDate)
        
        list.append(data)
        
        list.append(contentsOf: forecast.map {
            WidgetData(location: location,
                       temperature: $0.temperature,
                       icon: $0.icon,
                       weather: $0.description,
                       humidity: $0.humidity,
                       feelsLike: $0.feelsLike,
                       airPollution: "-",
                       date: $0.forecastDate)
        })
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            try data.write(to: dataURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func read() -> [WidgetData] {
        var list = [WidgetData]()
        
        if let data = try? Data(contentsOf: dataURL) {
            do {
                let decoder = JSONDecoder()
                
                list = try decoder.decode([WidgetData].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }

        
        return list
    }
    
}
