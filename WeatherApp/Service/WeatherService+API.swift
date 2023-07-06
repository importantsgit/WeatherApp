//
//  WeatherService+API.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation
import CoreLocation

extension WeatherService {
    
    func fetchWeather(location: CLLocation) async {
        do {
            let fetchedCurrentWeather = try await fetchCurrentWeather(location: location)
            let fetchedCurrentAirPollution = try await fetchCurrentAirPollution(location: location)
            
            currentWeather = CurrentWeather(
                weatherData: fetchedCurrentWeather,
                pollutionData: fetchedCurrentAirPollution
            )
            
            hourlyWeather = HourlyWeather(hourly: fetchedCurrentWeather.hourly)
            dailyWeather = DailyWeather(daily: fetchedCurrentWeather.daily)
            
            print(fetchedCurrentWeather, fetchedCurrentAirPollution)
        } catch {
            await MainActor.run {
                lassError = "Api 요청 실패"
            }
        }
    }
    
    private func fetchCurrentWeather(location: CLLocation) async throws -> CodableCurrentWeather {
        print("fetch")
        var components = URLComponents(string: "https://api.openweathermap.org/data/3.0/onecall")
        
        components?.queryItems = [
            URLQueryItem(name: "appid", value: Consts.shared.OPEN_WEATHER_API),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "exclude", value: "hourly,daily"),
            URLQueryItem(name: "lang", value: "kr"),
            URLQueryItem(name: "lat", value: "\(location.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.coordinate.longitude)")
        ]
        
        guard let url = components?.url else {
            throw ApiError.invalidUrl(components?.host ?? "")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print("데이터 받아오기")
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ApiError.failed(httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
        print(data)
        let result = try decoder.decode(CodableCurrentWeather.self, from: data)
        print(result)
        
        return result
    }
    
    private func fetchCurrentAirPollution(location: CLLocation) async throws -> CodableCurrentAirPollution {
        var components = URLComponents(string: "http://api.openweathermap.org/data/2.5/air_pollution/forecast")
        
        components?.queryItems = [
            URLQueryItem(name: "appid", value: Consts.shared.OPEN_WEATHER_API),
            URLQueryItem(name: "lat", value: "\(location.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.coordinate.longitude)")
        ]
        
        guard let url = components?.url else {
            throw ApiError.invalidUrl(components?.host ?? "")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ApiError.failed(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(CodableCurrentAirPollution.self, from: data)
        
        return result
    }
}
