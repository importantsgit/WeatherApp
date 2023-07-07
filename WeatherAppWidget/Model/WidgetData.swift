//
//  WidgetData.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
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
                                    weather: "맑음", humidity: Double.randomTemperatureString, feelsLike: Double.randomTemperatureString, airPollution: "Good", date: .now)
}

// AppGroup을 통해 앱과 위젯이 동일한 공간에 파일 저장할 수 있다.
