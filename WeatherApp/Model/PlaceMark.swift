//
//  PlaceMark.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import Foundation
import SwiftUI

class PlaceMark: Identifiable, ObservableObject {
    let id: UUID
    
    @Published var title: String
    @Published var imageURL: String?
    @Published var phoneNumber: String?
    @Published var address: String?
    @Published var placePhoto: Image?
    
    @Published var description: String?
    @Published var tag: String?
    
    init(title: String, imageURL: String?, phoneNumber: String?, address: String?, description: String?, tag: String?) {
        id = UUID()
        self.title = title
        self.imageURL = imageURL
        self.phoneNumber = phoneNumber
        
        self.address = address
        self.placePhoto = Image("photo")
        self.description = description
        self.tag = tag
    }
}

extension PlaceMark {
    static var sampleList: [PlaceMark] {
        return Array(repeating: PlaceMark(title: "동작구", imageURL: "https://unsplash.com/photos/LNRyGwIJr5c", phoneNumber: "01053609862", address: "방배동 902-28번지 1층 102호 서초구 서울특별시 KR", description: "그들은 우리는 못할 봄날의 유소년에게서 열매를 힘있다. 것은 사는가 물방아 이성은 방황하여도, 거친 하는 인생을 동산에는 황금시대다. 따뜻한 그들은 위하여, 듣는다. 쓸쓸한 장식하는 되는 미인을 무엇이 길지 커다란 그림자는 봄바람이다. 황금시대의 따뜻한 없으면, 예가 고행을 가는 피다. 시들어 이것은 불어 할지라도 교향악이다. 것은 있는 싹이 인생에 인간이 대중을 투명하되 피다. 간에 이는 주는 돋고, 얼마나 그들의 풀밭에 되려니와, 이것이다. 만천하의 구할 옷을 든 있는 원질이 운다. 피어나는 피고 가지에 광야에서 예가 두기 할지라도 이것은 되는 때문이다. 보이는 수 인간의 이는 품으며, 보라.", tag: "산림, 강좌, 국립"), count: 20)
    }
}
