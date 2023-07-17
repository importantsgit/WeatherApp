//
//  MapView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/12.
//

import SwiftUI
import MapKit

//UIViewRepresentable: UIKit 구성 요소 사용하기 위해 사용
struct MapViewCoordinator: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> some UIView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
