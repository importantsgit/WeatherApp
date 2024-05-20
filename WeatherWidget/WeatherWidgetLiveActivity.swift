//
//  WeatherWidgetLiveActivity.swift
//  WeatherWidget
//
//  Created by 이재훈 on 5/20/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WeatherWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WeatherWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WeatherWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WeatherWidgetAttributes {
    fileprivate static var preview: WeatherWidgetAttributes {
        WeatherWidgetAttributes(name: "Me")
    }
}

extension WeatherWidgetAttributes.ContentState {
    fileprivate static var smiley: WeatherWidgetAttributes.ContentState {
        WeatherWidgetAttributes.ContentState(value: 3)
    }
    
    fileprivate static var starEyes: WeatherWidgetAttributes.ContentState {
        WeatherWidgetAttributes.ContentState(value: 3)
    }
}

//#Preview{
//    WeatherWidgetAttributes(name: "Me")
//        .previewContext(WeatherWidgetAttributes.ContentState(value: 3), viewKind: .dynamicIsland(.compact))
//    
//}

#Preview("Notification", as: .content, using: WeatherWidgetAttributes.preview) {
   WeatherWidgetLiveActivity()
} contentStates: {
    WeatherWidgetAttributes.ContentState.smiley
    WeatherWidgetAttributes.ContentState.starEyes
}
