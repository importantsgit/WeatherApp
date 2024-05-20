//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 이재훈 on 5/20/24.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
