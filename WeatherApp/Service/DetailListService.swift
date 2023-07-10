//
//  DetailListService.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import Foundation

class DetailListService: NSObject/*delegate 상속받아야 됨*/, ObservableObject {


    @Published var placeMark: [PlaceMark] = []
    
    @Published var lastError: String?
    
    let isPreviewService: Bool
    
    init(preview: Bool = false) {
        isPreviewService = preview
        
        super.init()
    }
    
    static var preview: DetailListService {
        let service = DetailListService(preview: true)
        service.placeMark = PlaceMark.sampleList
        return service
    }
}
