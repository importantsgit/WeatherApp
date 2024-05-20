//
//  Collection+Utils.swift
//  WeatherApp
//
//  Created by 이재훈 on 5/20/24.
//

import Foundation

extension Dictionary {
    
    func merged(with other: [Key: Value]) -> [Key: Value] {
        var mergedDictionary = self
        other.forEach {
            mergedDictionary.updateValue($0.value, forKey: $0.key)
        }
        
        return mergedDictionary
    }

}
