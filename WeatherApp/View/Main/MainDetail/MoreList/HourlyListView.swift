//
//  HourlyListView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import SwiftUI

struct forecastHourlyListView: View {
    @Binding var model: [Forecast]?
    
    var body: some View {
        ForEach(model ?? []) { hourlyForcast in
            
            VStack(alignment: .center) {
                Text(hourlyForcast.day)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(checkID(hourlyForcast.id) ?
                        .white : Color(hex: "4D4D4D"))
                
                Image(hourlyForcast.icon)
                    .resizable()
                    .renderingMode(checkID(hourlyForcast.id) ? .template : .original)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                
                Text(hourlyForcast.temperature)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(checkID(hourlyForcast.id) ? .white : .black)
                
                Text(hourlyForcast.time)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(checkID(hourlyForcast.id) ? .white : Color(hex: "4D4D4D"))
                
            }
            .frame(width: 58, height: 132)
            .background(checkID(hourlyForcast.id) ? Color(hex: "4d4d4d") : Color.clear)
            .cornerRadius(8.0)
            .shadow(color: checkID(hourlyForcast.id) ? .gray : .clear , radius: 1, x: 0, y: 0)
        }
    }
    
    func checkID(_ id: UUID) -> Bool {
        return model?.first?.id == id
    }
}
