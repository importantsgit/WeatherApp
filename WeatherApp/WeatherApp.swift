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
    let manager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .preferredColorScheme(.light)
                .environmentObject(service)
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.mainContext)
        }
    }
}
