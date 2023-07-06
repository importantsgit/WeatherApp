//
//  MoreWeatherListView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct MoreWeatherListView: View {
    let model: CurrentWeather?
    @Binding var currentTapType: TapType
    
    var body: some View {

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Forecast.preview) { forecast in
                        if currentTapType == .Hourly {
                            VStack(alignment: .center) {
                                Image(forecast.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 36, height: 36)
                                
                                Text(forecast.temperature)
                                    .font(.system(size: 18, weight: .medium))
                                    .tint(.black)
                                
                                Text(forecast.time)
                                    .font(.system(size: 14, weight: .regular))
                                    .tint(Color(hex: "4D4D4D"))
                            }
                            .frame(width: 58, height: 112, alignment: .center)
                            .background(Color(hex: "4d4d4d"))
                            .cornerRadius(8.0)
                            .shadow(color: .gray, radius: 1, x: 0, y: 0)
                            
                        } else {
                            VStack(alignment: .center) {
                                Image(forecast.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 36, height: 36)
                                
                                Text(forecast.temperature)
                                    .font(.system(size: 18, weight: .medium))
                                    .tint(.black)
                                
                                Text(forecast.time)
                                    .font(.system(size: 14, weight: .regular))
                                    .tint(Color(hex: "4D4D4D"))
                            }
                            .frame(width: 58, height: 112, alignment: .center)

                        }
                    }
                }
                .padding([.leading, .trailing], 16.0)
                .frame(height: 112)

            }
           
        
    }
}

struct MoreWeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        MoreWeatherListView(model: CurrentWeather.preview, currentTapType: .constant(.Hourly))
    }
}
