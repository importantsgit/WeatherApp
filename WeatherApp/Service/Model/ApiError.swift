//
//  ApiError.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import Foundation

@frozen
enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case.unknown:
            return NSLocalizedString("알 수 없는 에리입니다.", comment: "unknown")
            
        case .invalidUrl(let string):
            return NSLocalizedString("허용되지 않은 URL입니다. : \(string)", comment: "invalidUrl")
            
        case .invalidResponse:
            return NSLocalizedString("허용되지 않은 응답입니다.", comment: "invalidResponse")
            
        case .failed(let code):
            return NSLocalizedString("에러 코드: \(code)", comment: "failed")
            
        case.emptyData:
            return NSLocalizedString("데이터가 없습니다.", comment: "emptyData")
        }
    }
}
