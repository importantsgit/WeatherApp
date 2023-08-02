//
//  DetailGridItem.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct DetailGridItem: View {
    @ObservedObject var placeMark: PlaceMarkEntity
    
    @Binding var PushDetailView: Bool

    
    var body: some View {
        Button {
            PushDetailView = true
        } label: {
            VStack(alignment: .leading ,spacing: 24) {
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
                    .frame(width: 78, height: 78)
                        
                    VStack(alignment: .leading ,spacing: 8) { 
                        
                        Text(placeMark.title ?? "")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 160, alignment: .leading)
                            .lineLimit(1)
                        
                        VStack(alignment: .leading ,spacing: 6) {
                            HStack {
                                Text("전화번호")
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 50)
                                
                                Text(placeMark.phoneNumber
                                    .format(with: "XXX-XXXX-XXXX"))
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 160, alignment: .leading)
                            }
                            .foregroundColor(Color(hex: "4D4D4D"))
                            
                            HStack {
                                Text("주소지")
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 50, alignment: .leading)
                                
                                Text(placeMark.address ?? "")
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
}

struct DetailGridItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailGridItem(placeMark: PlaceMarkEntity(context: CoreDataManager.shared.mainContext), PushDetailView: .constant(false))
    }
}
