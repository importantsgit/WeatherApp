//
//  DetailGridItem.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct DetailGridItem: View {
    var placeMark: PlaceMark
    
    @Binding var PushDetailView: Bool

    
    var body: some View {
        Button {
            PushDetailView = true
        } label: {
            VStack(alignment: .leading ,spacing: 36) {
                HStack(alignment: .center ,spacing: 16) {
                    AsyncImage(url: URL(string: "https://picsum.photos/200/300")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 78, height: 78)
                            .cornerRadius(10)
                            .shadow(radius: 4, x: 2, y: 2)
                        
                    } placeholder: {
                        ProgressView()
                    }
//                    placeMark.placePhoto
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 78, height: 78)
//                        .cornerRadius(10)
//                        .shadow(radius: 4, x: 2, y: 2)
                        
                    VStack(alignment: .leading ,spacing: 8) {
                        
                        Text(placeMark.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading ,spacing: 6) {
                            HStack {
                                Text("전화번호")
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 50, alignment: .leading)
                                
                                Text(format(with: "XXX-XXXX-XXXX", phone: placeMark.phoneNumber))
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .foregroundColor(Color(hex: "4D4D4D"))
                            
                            HStack {
                                Text("주소지")
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 50, alignment: .leading)
                                
                                Text(placeMark.address)
                                    .font(.system(size: 14, weight: .regular))
                                    .lineLimit(1)
                                    .frame(width: 160, alignment: .leading)
                            }
                            .foregroundColor(Color(hex: "4D4D4D"))
                        }
                    }
                }
            }
            .frame(height: 100)
        }


    }
    
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
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

struct DetailGridItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailGridItem(placeMark: PlaceMark.sampleList[0], PushDetailView: .constant(false))
    }
}
