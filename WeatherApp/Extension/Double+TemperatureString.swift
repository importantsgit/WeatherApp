//
//  Double+TemperatureString.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/05.
//

import Foundation

fileprivate let formatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    f.numberFormatter.maximumFractionDigits = 0
    f.unitOptions = .temperatureWithoutUnit
    return f
}()

extension Double {
    var temperatureString: String {
        let temperature = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return formatter.string(from: temperature)
    }
    
    static var randomTemperatureString: String {
        return Double.random(in: -10...30).temperatureString
    }
}


extension String? {
    func format(with mask: String) -> String {
        guard let self = self else { return "EmptyString" }
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }

        }
        return result
    }
}
