//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: CoreDataManager
    @ObservedObject var placeMark: PlaceMarkEntity
    
    @State private var showMenuDialog = false
    @State private var image: UIImage? = nil
    @State private var isImageLoading: Bool = true
    
    var location: [String?]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                
                DetailImageView(image: $image, isLoading: $isImageLoading)
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
        .onAppear {
            guard let urlString = placeMark.imageURL
            else {
                isImageLoading = false
                return
            }
            loadImage(urlString: urlString)
        }
        
    }
    
    func getTag() -> String {
        return placeMark.tag?.split(separator: ", ", omittingEmptySubsequences: true).map{"#" + String($0) + " "}.reduce("", {$0+$1}) ?? "no tag"
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString)
        else { return }
        
        Task {
            do {
                let image = try await ImageCache.shared.load(url: url as NSURL)
                
                await MainActor.run {
                    isImageLoading = false
                    self.image = image
                }
            }
            catch {
                isImageLoading = false
                print(error.localizedDescription)
            }
            
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(placeMark: PlaceMarkEntity(context: CoreDataManager.shared.mainContext), location: ["강원","청주"])
        }
    }
}

struct DetailImageView: View {
    @Binding var image: UIImage?
    @Binding var isLoading: Bool
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.white, location: 0),
            .init(color: .clear, location: 0.2)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .overlay {
                    EmptyView()
                        .background(Color("backgroundColor"))
                        .mask(gradient)
                }
                .clipped()
        }
        else if isLoading {
            ProgressView()
            
        }
        else {
            Color.gray
        }
    }
}
