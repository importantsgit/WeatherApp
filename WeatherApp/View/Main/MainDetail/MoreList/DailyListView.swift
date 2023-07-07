//
//  DailyListView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import SwiftUI

struct forecastDailyListView: View {
    @Binding var model: [Forecast]?
    
    var body: some View {
        ForEach(model ?? []) { dailyForcast in
            VStack(alignment: .center) {
                Text(dailyForcast.day)
                    .font(.system(size: 14, weight: .bold))
                    .tint(Color(hex: "4D4D4D"))
                
                Image(dailyForcast.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                
                Text(dailyForcast.temperature)
                    .font(.system(size: 18, weight: .medium))
                    .tint(.black)
                
                Text(dailyForcast.time)
                    .font(.system(size: 14, weight: .regular))
                    .tint(Color(hex: "4D4D4D"))
            }
            .frame(width: 58, height: 132, alignment: .center)
        }
    }
}
