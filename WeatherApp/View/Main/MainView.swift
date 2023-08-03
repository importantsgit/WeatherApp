//
//  MainView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var service: WeatherService
    @State private var currentTapType = TapType.Hourly
    @State private var pushListView = false
    
    var body: some View {
        NavigationStack {
            
            GeometryReader { reader in
                VStack(alignment: .center ,spacing: 72) {
                    
                    CurrentWeatherView()
                    
                    CurrentWeatherDetailView()
        
                    VStack(spacing: 24) {
                        MainButtonMenu(currentTapType: $currentTapType)
                        
                        MoreWeatherListView(currentTapType: $currentTapType)
                    }
                    .frame(height: 200)

                }
                .frame(height: reader.size.height)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        if service.currentLocation.count == 1 {
                            Text(service.currentLocation[0] ?? " ")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color(hex: "3A3A3A"))
                        } else {
                            Text(service.currentLocation[0] ?? " ")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "3A3A3A"))
                            Text(service.currentLocation[1] ?? "")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(Color(hex: "4D4D4D"))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        pushListView = true
                    } label: {
                        Image("Location")
                    }
                }
                
            }
            .background {
                Color("backgroundColor")
                    .ignoresSafeArea()
            }
            .onAppear {
                service.fetch()
            }
            .navigationDestination(isPresented: $pushListView) {
                LocationListView(location: $service.currentLocation)
            }
        }
        .accentColor(Color(hex: "3A3A3A"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(WeatherService.preview)
            .preferredColorScheme(.light)
        MainView()
            .environmentObject(WeatherService.preview)
            .preferredColorScheme(.dark)
    }
}

