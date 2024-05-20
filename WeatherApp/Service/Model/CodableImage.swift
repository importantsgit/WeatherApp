//
//  CodableImage.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation


typealias Photos = [Photo]

struct Photo: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
