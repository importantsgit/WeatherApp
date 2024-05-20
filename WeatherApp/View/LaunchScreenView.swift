//
//  LaunchScreenView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/07.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var service: WeatherService
    @State var isFetched = false
    @State var hasError = false

    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 128)

                if !service.isFetched {
                    ProgressView()
                        .scaleEffect(2, anchor: .center)
                        .tint(.black)
                        .onAppear {
                            service.fetch()
                        }
                } else if service.lastError != nil && service.isFetched {
                    Button {
                        hasError = true
                    } label: {
                        Text("다시 불러오기")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .sheet(isPresented: $hasError) {
                        ErrorView()
                    }
                } else {
                    MainView()
                }
            }
            .animation(.easeInOut, value: service.isFetched)
        }

    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(WeatherService())
    }
}
