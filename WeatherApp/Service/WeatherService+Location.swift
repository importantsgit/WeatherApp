//
//  WeatherService+Location.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation
import CoreLocation

extension WeatherService: CLLocationManagerDelegate {
    
    // 좌표 받아서 위치 문자열로 반환
    private func updateAddress(from location: CLLocation) async throws -> [String] {
        let geocoder = CLGeocoder()
        // 지리적 좌표와 지명 간의 변환을 위한 인터페이스
        let placemarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "Ko_kr"))
        
        if let placemark = placemarks.first {
            if let gu = placemark.locality, let dong = placemark.subLocality {
                return ["\(gu)", "\(dong)"]
            } else {
                return ["\(placemark.name ?? "알 수 없음")", "" ]
            }
        }
        return ["알 수 없음", ""]
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
        case .notDetermined:
            lassError = "위치 서비스 사용 권한을 확인할 수 없습니다."
            
        case .denied, .restricted:
            lassError = "알 수 없는 오류가 발생했습니다."
        @unknown default:
            fatalError()
        }
    }
    
    // api 요청 코드도 같이 불러오기
    private func process(location: CLLocation) {
        guard !isPreviewService else { return }
        
        Task.detached {  @MainActor [weak self] in
            guard let self = self else {return}
            currentLocation = try await updateAddress(from: location)
            await fetchWeather(location: location)
            //비동기 함수
        }
    }
    
    // 좌표 처리
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            process(location: location)
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        lassError = error.localizedDescription
    }
}
