//
//  ApiError.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
