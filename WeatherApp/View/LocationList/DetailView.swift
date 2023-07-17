//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct DetailView: View {
    @State private var showMenuDialog = false
    
    var placeMark: PlaceMark
    var location: [String?]
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.white, location: 0),
            .init(color: .clear, location: 0.2)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 36) {
                    Image("photo2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .overlay {
                        EmptyView()
                            .background(Color("backgroundColor"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            //.blur(radius: 20)
                            .mask(gradient)
                    }
                    .clipped()
                    
                    
                    VStack(alignment: .leading ,spacing: 10) {
                        
                        VStack(spacing: 24) {
                            VStack(spacing: 8) {
                                Text(placeMark.title)
                                    .font(.system(size: 32, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                
                                Text(
                                    location
                                    .compactMap{$0 ?? ""}
                                        .joined(separator: " ")
                                )
                                .font(.system(size: 16, weight: .regular))
                                .frame(maxWidth: .infinity)
                            }

                            
                            Text(placeMark.description ?? "")
                                .font(.system(size: 14, weight: .regular))
                                
                        }

                        Divider()
                            .padding([.top,.bottom], 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Label(placeMark.phoneNumber ?? ""
                                .format(with: "XXX-XXXX-XXXX"), systemImage: "phone")
                            
                                .font(.system(size: 13, weight: .regular))
                            
                            Label(placeMark.address ?? "", systemImage: "location")
                                .font(.system(size: 13, weight: .regular))
                        }
                    }
                    .padding([.leading, .trailing], 32)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                
                    Button {
                        showMenuDialog = true
                    } label: {
                        Image(systemName: "ellipsis")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color(hex: "2B2B2B"))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .tint(Color.black)
                    


                    .confirmationDialog("메뉴", isPresented: $showMenuDialog) {
                        Button(role: .none) {
                            
                        } label: {
                            Text("수정하기")
                        }

                        Button(role: .destructive) {
                            
                        } label: {
                            Text("삭제하기")
                        }

                    }

                }
            }
            .ignoresSafeArea(.container, edges: .top)
            .background {
                Color("backgroundColor")
                    .ignoresSafeArea()
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(placeMark: PlaceMark.sampleList[0], location: ["강원","청주"])
        }
    }
}
