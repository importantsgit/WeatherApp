//
//  ErrorView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var service: WeatherService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .font(.largeTitle)
            
            if let error = service.lastError {
                Text(error)
                    .padding()
            }
            
            Button("다시 요청") {
                service.lastError = nil
                service.fetch()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .background(Color.white)
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
            .environmentObject(WeatherService.preview)
    }
}
