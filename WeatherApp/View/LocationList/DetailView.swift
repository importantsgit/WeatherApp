//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var manager: CoreDataManager
    @State private var showMenuDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var placeMark: PlaceMarkEntity
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
        ScrollView {
            VStack(spacing: 36) {
                
                AsyncImage(url: URL(string: "https://picsum.photos/200/300")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .overlay {
                            EmptyView()
                                .background(Color("backgroundColor"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .mask(gradient)
                        }
                        .clipped()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                
                VStack(alignment: .leading ,spacing: 10) {
                    
                    VStack(spacing: 24) {
                        VStack(spacing: 8) {
                            Text(placeMark.title ?? "-")
                                .font(.system(size: 32, weight: .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(placeMark.address ?? "-")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(hex: "636363"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Text(placeMark.body ?? "-")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(hex: "474747"))
                            .frame(maxWidth: .infinity, minHeight: 50, alignment: .topLeading)
                    }

                    Divider()
                        .padding([.top,.bottom], 24)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Label(placeMark.phoneNumber
                            .format(with: "XXX-XXXX-XXXX"), systemImage: "phone")
                        
                            .font(.system(size: 13, weight: .regular))
                        
                        Label(getTag(), systemImage: "tag")
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

                    NavigationLink {
                        ListEditView(placeMark: placeMark)
                    } label: {
                        Text("수정하기")
                    }

                    Button(role: .destructive) {
                        manager.delete(placeMark: placeMark)
                        dismiss()
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
    
    func getTag() -> String {
        return placeMark.tag?.split(separator: ", ", omittingEmptySubsequences: true).map{"#" + String($0) + " "}.reduce("", {$0+$1}) ?? "no tag"
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(placeMark: PlaceMarkEntity(context: CoreDataManager.shared.mainContext), location: ["강원","청주"])
        }
    }
}
