//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by 이재훈 on 2023/07/07.
//

import WidgetKit
import SwiftUI

struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
           WeatherEntryView(entry: entry)
        }
        .configurationDisplayName("WeatherApp")
        // 제목
        .description("오늘의 날씨를 확인해보세요")
        // 설명
        .supportedFamilies([.systemSmall])
        // 지원되는 템플릿
    }
}

struct WeatherAppWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntryView(entry: WeatherEntry(widgetData: .preview))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

