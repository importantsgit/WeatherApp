//
//  FileManager+SharedContainer.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import Foundation

extension FileManager {
    static var sharedContainer: URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Cudo.WeatherApp.WeatherAppWidget.contents")
    }
}
