//
//  MapView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/12.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailMapView: View {
    var parent = MapView()
    
    var body: some View {
        ZStack {
            parent
                .ignoresSafeArea()
            Text("hello")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapView()
    }
}

