//
//  PhotoService.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation
import UIKit
import SwiftUI

final class PhotoService: NSObject {
    static let shared = PhotoService()
    
    
    func fetch<parsingType: Codable>(
        type: Consts.PHOTO_URL,
        headers: [String: Any] = [:],
        param: [String: Any] = [:]
    ) async throws -> parsingType {
        var components = URLComponents(string: type.rawValue)
        var queryItems = [URLQueryItem]()
        param.forEach {
            queryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        components?.queryItems = queryItems
        
        guard let url = components?.url else { throw ApiError.invalidUrl(components?.host ?? "") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 5.0
        
        headers.forEach {
            request.addValue("\($0.value)", forHTTPHeaderField: $0.key)
        }
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw ApiError.failed(httpResponse.statusCode)
        }
        let result = try JSONDecoder().decode(parsingType.self, from: data)
        print(result)
        
        return result
    }
}


public protocol Item {
    var photo: UIImage? { get set }
    var imageURL: URL { get }
    var identifier: String { get }
}

public final class ImageCache: NSObject {
    public static let shared = ImageCache()
    
    public let cachedImages = NSCache<NSURL, UIImage>()
    private var waitingResponseContinuation = [NSURL: [CheckedContinuation<UIImage?, Never>]]()
    
    private override init() {
        super.init()
        cachedImages.delegate = self
    }
    
    
    
    private func image(url: NSURL) -> UIImage? {
        cachedImages.object(forKey: url)
    }
    
    func load(url: NSURL) async throws -> UIImage? {
        if let cachedImage = image(url: url) {
            return cachedImage
        }
        
        if waitingResponseContinuation[url] != nil {
            return await withCheckedContinuation { continuation in
                waitingResponseContinuation[url]?.append(continuation)
            }
        }
        
        // persistent storage에 저장하지 않는 세션
        // 따로 NSCache를 사용 -> URLSession에서 cache를 사용하지 않게끔 설정
        let urlSession = URLSession(configuration: .ephemeral)
        
        let (data, response) = try await urlSession.data(from: url as URL)
        
        guard let httpResponse = response as? HTTPURLResponse 
        else { throw ApiError.invalidResponse }
        
        guard 200...299 ~= httpResponse.statusCode
        else { throw ApiError.failed(httpResponse.statusCode)}
        
        print(data, url)
        guard let image = UIImage(data: data) else {
            throw ApiError.emptyData
        }
        
        cachedImages.setObject(image, forKey: url, cost: data.count)
        
        let continations = waitingResponseContinuation[url] ?? []
        waitingResponseContinuation[url] = nil
        
        for contination in continations {
            
            contination.resume(returning: image)
        }
        print("Success")
        return image
    }
}

extension ImageCache: NSCacheDelegate {
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print("Cache will remove: \(obj)")
    }
}
