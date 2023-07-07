//
//  WeatherService+API.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation
import CoreLocation

extension WeatherService {
    
    @MainActor
    func fetchWeather(location: CLLocation) async {
        do {
            
            // await로 fetch를 호출한 다음 -> fetch 리턴하면 다시 돌아오는데 fetch를 호출한 쓰레드에서 돌아간다는 보장이 없음
            // 네트워크 요청 코드는 background에서 호출
            async let fetchedCurrentWeather: CodableCurrentWeather = fetch(type: .CURRENT, location: location)
            async let fetchedCurrentAirPollution = fetchCurrentAirPollution(location: location)
            async let fetchedForecast: CodableForecast = fetch(type: .FORECAST, location: location)
            
            // 내용이 수정되면 UI가 업데이트 되는데 Main 스레드에서 바꿔야 한다
            // fetch할 때는 background에서 돌아가고 다시 돌아올때는 메인 스레드에서 돌아간다
            currentWeather = CurrentWeather(
                weatherData: try await fetchedCurrentWeather,
                pollutionData: try await fetchedCurrentAirPollution
            )
            
            forecastHourlyList = try await fetchedForecast.list[0...2].compactMap {
                Forecast(data: $0)
            }
            
            forecastDailyList = try await fetchedForecast.list[3...].compactMap {
                Forecast(data: $0)
            }
        } catch {
            await MainActor.run {
                lastError = "Api 요청 실패"
            }
        }
    }
    
    private func fetch<ParsingType: Codable>(type: Consts.OPEN_WEATHER_URL, location: CLLocation) async throws -> ParsingType {
        var components = URLComponents(string: type.rawValue)
        
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
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ApiError.failed(httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
        let result = try decoder.decode(ParsingType.self, from: data)
        
        return result
    }
    
    private func fetchCurrentAirPollution(location: CLLocation) async throws -> CodableCurrentAirPollution {
        var components = URLComponents(string: Consts.OPEN_WEATHER_URL.AIR_POLLUTION.rawValue)
        
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
