//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import SwiftUI

@main
struct WeatherApp: App {
    let service = WeatherService()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
                .environmentObject(service)
        }
    }
}
