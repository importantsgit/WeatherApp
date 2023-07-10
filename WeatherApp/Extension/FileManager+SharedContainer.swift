//
//  FileManager+SharedContainer.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import Foundation

extension FileManager {
    static var sharedContainerURL: URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Cudo.WeatherApp.WeatherAppWidget")!
    }
}
