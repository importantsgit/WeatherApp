//
//  WeatherEntry.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation
import WidgetKit

// 위젯에 표시하는 개별 데이터는 TimeLineEntry 채택
// 위젯을 표시할 날짜를 지정, 위젯 콘텐츠의 현재 관련성
struct WeatherEntry: TimelineEntry {
    let widgetData: WidgetData
    
    var date: Date {
        widgetData.date
    }
}
