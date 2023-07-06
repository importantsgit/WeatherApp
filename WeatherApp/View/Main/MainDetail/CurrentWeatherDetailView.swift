//
//  CurrentWeatherDetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct CurrentWeatherDetailView: View {
    let model: CurrentWeather?
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .center, spacing: 16.0) {
                if let model = model {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 16.0) {
                            HStack {
                                Text("feels like")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(hex: "4D4D4D"))
                                    .padding(.trailing, 16.0)
                                
                                Text(model.feelsLike)
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(width: 36, alignment: .trailing)
                            }
                            
                            HStack {
                                Text("humidity")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(hex: "4D4D4D"))
                                    .padding(.trailing, 16.0)
                                
                                Text(model.humidity)
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(width: 36, alignment: .trailing)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 16.0) {
                            HStack(alignment: .center, spacing: 8.0) {
                                Text("sunrise")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(hex: "4D4D4D"))
                                    .padding(.trailing, 16.0)
                                
                                Text(model.sunrise)
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(width: 60, alignment: .trailing)
                            }
                            
                            HStack(alignment: .center, spacing: 8.0) {
                                Text("sunset ")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(hex: "4D4D4D"))
                                    .padding(.trailing, 16.0)
                                
                                Text(model.sunset)
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(width: 60, alignment: .trailing)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("air Pollution")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(hex: "4D4D4D"))
                            .padding(.trailing, 16.0)
                        
                        Text(model.airPollution)
                            .font(.system(size: 20, weight: .medium))
                    }
                }


            }
            .frame(width: reader.size.width)
        }
    }
}

struct CurrentWeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherDetailView(model: CurrentWeather.preview)
            .environmentObject(WeatherService.preview)
    }
}
