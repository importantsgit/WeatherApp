//
//  WeatherEntry.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import Foundation
import WidgetKit

// 위젯에 표시하는 개별 데이터는 TimelineEntry채택
struct WeatherEntry: TimelineEntry {
    let widgetData: WidgetData
    
    var date: Date {
        widgetData.date
    }
}
