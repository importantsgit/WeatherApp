//
//  MoreWeatherListView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct MoreWeatherListView: View {
    @EnvironmentObject var service: WeatherService
    @Binding var currentTapType: TapType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                if currentTapType == .Hourly {
                    forecastHourlyListView(model: $service.forecastHourlyList)
                } else {
                    forecastDailyListView(model: $service.forecastDailyList)
                }
            }
            .padding([.leading, .trailing], 16)
        }
    }
}

struct MoreWeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        MoreWeatherListView(currentTapType: .constant(.Hourly))
            .environmentObject(WeatherService.preview)
    }
}
