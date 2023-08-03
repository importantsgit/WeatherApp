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
        ZStack {
            MapViewCoordinator(locationManager: manager)
                .ignoresSafeArea()
                .onDisappear {
                    print("timer was invalidated")
                    manager.geocodertimer?.invalidate()
                    manager.geocodertimer = nil
                }
                .overlay {
                    Image(manager.isLocationChange ? "mark.down" : "mark.up")
                        .resizable()
                        .frame(width: 72, height: 72)
                }
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    Button {
                        manager.mapViewFocusChange()
                    } label: {
                        Image(systemName: manager.isLocationChange ? "figure.wave" : "figure.walk")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .padding(16)
                            .foregroundColor(.white)
                            .background(Color(hex: "2B2B2B"))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    

                }
                .frame(height: 600, alignment: .bottomTrailing)
                .padding(.trailing, 24)
                .padding(.bottom, 64)
                
                BottomBarBackgroundView()
                    .frame(height: 110, alignment: .bottom)
                    .shadow(color: .gray, radius: 4, x:0 ,y:-4)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                address = manager.currentPlace
                                dismiss()
                            } label: {
                                Text(manager.currentPlace)
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.black)
                        }
                    }
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

struct BottomBarBackgroundView: View {
    var body: some View {
        Color("backgroundColor")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailMapView(address: .constant("hello"))
        }
    }
}

