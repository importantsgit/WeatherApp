//
//  PlaceMark.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import Foundation
import SwiftUI

struct PlaceMark: Identifiable {
    let id: UUID
    
    let title: String
    let phoneNumber: String
    let address: String
    let placePhoto: Image
    
    let description: String
    let tag: String
}

extension PlaceMark {
    static var sampleList: [PlaceMark] {
        return Array(repeating: PlaceMark(id: UUID(), title: "동작구", phoneNumber: "01053609862", address: "방배동 902-28번지 1층 102호 서초구 서울특별시 KR", placePhoto: Image("photo"), description: "안녕하십니까, 저는 이재훈입니다.", tag: "산림, 강좌, 국립"), count: 20)
    }
    
    init?(placeMark: CodablePlaceMark) {
        id = placeMark.id
        title = placeMark.title
        phoneNumber = placeMark.phoneNumber
        
        address = placeMark.address
        placePhoto = Image("photo")
        description = placeMark.description
        tag = placeMark.tag
    }
}

struct CodablePlaceMark: Codable {
    let id: UUID
    let title: String
    let phoneNumber: String
    let address: String
    let imageURL: URL
    let description: String
    let tag: String
}
