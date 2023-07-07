//
//  WeatherAppWidgetBundle.swift
//  WeatherAppWidget
//
//  Created by 이재훈 on 2023/07/07.
//

import WidgetKit
import SwiftUI

@main
struct WeatherAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherAppWidget()
        WeatherAppWidgetLiveActivity()
    }
}
