//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct CurrentWeatherView: View {
    let model: CurrentWeather?
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .center, spacing: 8) {
                if let model = model {
                    Image(model.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .padding(.top, 36)
                    
                    Text(model.temperature)
                        .font(.system(size: 60, weight: .medium))
                        .padding(.leading, 8)
                    
                    Text(model.forecastedDate.description)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(hex: "515050"))
                }
            }
            .frame(width: reader.size.width)
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(model: .preview)
            .environmentObject(WeatherService.preview)
    }
}
