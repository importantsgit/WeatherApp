//
//  MainButtonMenu.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

enum TapType {
    case Daily
    case Hourly
}

struct MainButtonMenu: View {
    @Binding var currentTapType: TapType
    
    var body: some View {
        
        HStack {
            Spacer()
            
            Button {
                currentTapType = .Hourly
            } label: {
                Text("Hourly")
                    .font(.system(size: 18, weight: .medium))
                    .padding([.leading, .trailing], 16.0)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(currentTapType == .Hourly ? .black : .clear)
            .foregroundColor(currentTapType == .Hourly ? .white : .gray)
            .overlay {
                if currentTapType != .Hourly {
                    Capsule(style: .continuous)
                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 2))
                }
            }
            
            Spacer()
            
            Button {
                currentTapType = .Daily
            } label: {
                Text("Daily")
                    .font(.system(size: 18, weight: .medium))
                    .padding([.leading, .trailing], 16.0)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(currentTapType == .Daily ? .black : .clear)
            .foregroundColor(currentTapType == .Daily ? .white : .gray)
            .overlay {
                if currentTapType != .Daily {
                    Capsule(style: .continuous)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                }
            }
            
            Spacer()
        }
    }
}

struct MainButtonMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonMenu(currentTapType: .constant(.Daily))
    }
}
