//
//  WeatherService.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation
import CoreLocation

class WeatherService: NSObject/*delegate 상속받아야 됨*/, ObservableObject {
    static let apiKey = Consts.shared.OPEN_WEATHER_API
    
    let locationManager: CLLocationManager
    
    @Published var currentLocation: [String?]
    
    @Published var currentWeather: CurrentWeather?
    @Published var dailyWeather: DailyWeather?
    @Published var hourlyWeather: HourlyWeather?
    @Published var forecastList: [Forecast]?
    
    @Published var lassError: String?
    
    let isPreviewService: Bool
    
    init(preview: Bool = false) {
        isPreviewService = preview
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        currentLocation = ["", ""]
        
        super.init()
        
        locationManager.delegate = self
    }
    
    static var preview: WeatherService {
        let service = WeatherService(preview: true)
        service.currentWeather = CurrentWeather.preview
        service.forecastList = Forecast.preview
        
        return service
    }
    
    func fetch() {
        guard !isPreviewService else {return}
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
        case .denied, .restricted:
            lassError = "위치 서비스 사용 권한이 없습니다."
        
        default:
            lassError = "알 수 없는 오류가 발생했습니다."
        }
    }
}
