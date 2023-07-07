//
//  WeatherEntryView.swift
//  WeatherAppWidgetExtension
//
//  Created by 이재훈 on 2023/07/07.
//

import SwiftUI
import WidgetKit

struct WeatherEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading){
                        Text(entry.widgetData.location)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "3A3A3A"))
                        
                        Text(entry.widgetData.temperature)
                            .font(.largeTitle)
                            .foregroundColor(Color(hex: "4D4D4D"))
                            .frame(width: 56, alignment: .leading)
                    }
                    
                    Image(entry.widgetData.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                }
                
                VStack(spacing: 2) {
                    HStack {
                        Text("습도")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(hex: "3A3A3A"))
                            .frame(width: 60, alignment: .leading)
  
                        
                        Text(entry.widgetData.humidity)
                            .font(.system(size: 13, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    HStack {
                        Text("체감 온도")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(hex: "3A3A3A"))
                            .frame(width: 60, alignment: .leading)
                        
                        Text(entry.widgetData.feelsLike)
                            .font(.system(size: 13, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    HStack {
                        Text("미세 먼지")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(hex: "3A3A3A"))
                            .frame(width: 60, alignment: .leading)
                        
                        Text(entry.widgetData.airPollution)
                            .font(.system(size: 13, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

            
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background {
                Color("backgroundColor")
            }
            
        }
    }
}

struct WeatherEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntryView(entry: Provider.Entry(widgetData: .preview))
        // 위젯을 추가할 때는 이렇게 만들자
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
