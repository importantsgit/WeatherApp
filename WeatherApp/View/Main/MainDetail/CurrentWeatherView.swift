//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var service: WeatherService
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let currentWeather = service.currentWeather {
                Image(currentWeather.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
                    .padding(.top, 36)

                
                Text(currentWeather.temperature)
                    .font(.system(size: 60, weight: .medium))
                    .padding(.leading, 8)
                
                Text(currentWeather.description)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(hex: "515050"))
            }
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(WeatherService.preview)
    }
}
