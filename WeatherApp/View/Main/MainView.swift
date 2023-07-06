//
//  MainView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var service: WeatherService
    
    @State private var currentTapType = TapType.Daily
    
    
    var body: some View {
        NavigationView {
            VStack {
            
                CurrentWeatherView(model: service.currentWeather)
                
                CurrentWeatherDetailView(model: service.currentWeather)
                .padding(.top, 64)
                
                GeometryReader { reader in
                    VStack(spacing: 16.0) {
                        MainButtonMenu(currentTapType: $currentTapType)
                        
                        MoreWeatherListView(currentTapType: $currentTapType)
                    }
                }
                .padding(.top, 24)

                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(service.currentLocation[0] ?? " ")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "3A3A3A"))
                        Text(service.currentLocation[1] ?? "")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(Color(hex: "4D4D4D"))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .tint(Color(hex: "3A3A3A"))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
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
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environmentObject(WeatherService.preview)
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(WeatherService.preview)
    }
}

