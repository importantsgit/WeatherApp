//
//  LocationManger.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/17.
//

import SwiftUI
import MapKit
import UIKit

class LocationManager: NSObject, ObservableObject {
    @Published var mapView: MKMapView = .init()
    @Published var currentPlace: String = ""
    @Published var isLocationChange: Bool = false
    
    
    private var manager: CLLocationManager = .init()
    private var currentGeoPoint: CLLocationCoordinate2D?
    private var currentPlacemark: CLLocation?
    
    lazy var geocodertimer: Timer? = {
        var timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(updateGeocoder), userInfo: nil, repeats: true)
        return timer
    }()
    
    override init() {
        super.init()
        geocodertimer?.fire()
     
        self.configureLocationManager()
    }
    
    @objc func updateGeocoder() {
        print("updateGeocoder")
        Task { @MainActor in
            guard let currentPlacemark = currentPlacemark else {return}
            self.currentPlace = try await updateAddress(location: currentPlacemark)
        }
    }
    
    private func configureLocationManager() {
        mapView.delegate = self
        manager.delegate = self
        
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    //MARK: 너무 빨리 호출하여 오류 발생
    private func updateAddress(location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()
        
        let placeMarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "Ko_kr"))
        guard let placeMark = placeMarks.first else { return "" }
        return "\(placeMark.country ?? "") \(placeMark.locality ?? "") \(placeMark.name ?? "")"
    }
}

extension LocationManager: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.isLocationChange = false
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location: CLLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        currentPlacemark = location
        DispatchQueue.main.async {
            self.isLocationChange = true
        }
    }
    
    //MARK: 특정 위치로 이동하는 메서드
    func mapViewFocusChange() {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: self.currentGeoPoint ?? CLLocationCoordinate2D(latitude: 37.496486063, longitude: 127.028361548), span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location else {
                print("위치를 찾을 수 없습니다.")
                return
            }
            
            self.currentGeoPoint = location.coordinate
            self.mapViewFocusChange()
            
            currentPlacemark = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
