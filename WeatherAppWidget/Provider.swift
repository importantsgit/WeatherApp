//
//  Provider.swift
//  WeatherAppWidgetExtension
//
//  Created by 이재훈 on 2023/07/07.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(widgetData: .preview)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(widgetData: .preview)
        completion(entry)
    }

    // 위젯에 표시할 데이터를 timeline형식으로 바꿔서 집어넣어야 한다.
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        var entries = [WeatherEntry(widgetData: .preview)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
