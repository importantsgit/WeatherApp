//
//  MapView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/12.
//

import SwiftUI
import MapKit

//UIViewRepresentable: UIKit 구성 요소 사용하기 위해 사용
struct MapView: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeCoordinator() -> MapCoordinator {
         return MapCoordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("context.coordinator.location")
        //locationManager.currentLocation = context.coordinator.location
    }
    
    
}

extension MapView {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        var location: CLLocation?
        
        init(parent: MapView) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: .init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            var coordinate = mapView.centerCoordinate
            self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            //print(coordinate.latitude, coordinate.longitude)
        }
    }
}
