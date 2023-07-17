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
    @StateObject var manager = LocationManager()
    @Binding var address: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        MapViewCoordinator(locationManager: manager)
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        address = manager.currentPlace
                        dismiss()
                    } label: {
                        Text(manager.currentPlace)
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "back")
                    }

                }
            }
            .onDisappear {
                print("timer was invalidated")
                manager.geocodertimer?.invalidate()
                manager.geocodertimer = nil
            }

    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailMapView(address: .constant("hello"))
        }
    }
}

