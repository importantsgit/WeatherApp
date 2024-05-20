//
//  Provider.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation
import WidgetKit

// 시간을 정해주면 그 시간에 맞춰 그 시간의 View를 Widget으로 전송하여 업데이트
internal struct Provider: TimelineProvider {
    
    // 기본적으로 화면에 보여주어야 할 값
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(widgetData: .preview)
    }

    // 위젯을 고를 때, 미리보기에서 보여지는 데이터를 설정하는 단계
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        var data = WidgetData.preview
        
        if !context.isPreview {
            let list = WidgetData.read()
            if !list.isEmpty {
                data = list[0]
            }
        }
        
        let entry = WeatherEntry(widgetData: data)
        completion(entry)
    }

    // 위젯에 표시할 데이터를 timeline형식으로 바꿔서 집어넣어야 한다.
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let entries = WidgetData.read().map {
            WeatherEntry(widgetData: $0)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        //policy
        // 1. atEnd: 타임라인의 마지막 날짜가 지난 후 WidgetKit이 새로운 타임라인을 요청하도록 지정하는 정책
        // 2. after: WidgetKit이 새로운 터임라인을 요청할 미래 날짜를 지정하는 정책
        // 3. never: 새 타임라인을 사용할 수 있을 때 앱이 Widget에 메시지를 표시하도록 지정
        completion(timeline)
    }
}
 
