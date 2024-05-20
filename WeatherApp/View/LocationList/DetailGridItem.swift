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
    @State private var image: UIImage? = nil {
        didSet {
            print(image)
        }
    }
    @State private var isImageLoading: Bool = true
    
    var body: some View {
        Button {
            PushDetailView = true
        } label: {
            VStack(alignment: .leading ,spacing: 24) {
                
                HStack(alignment: .center ,spacing: 16) {
                    
                    GridImageView(image: $image, isLoading: $isImageLoading)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 78, height: 78)
                        .cornerRadius(10)
                        .shadow(radius: 4, x: 2, y: 2)
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
        .onAppear {
            guard let urlString = placeMark.imageURL
            else {
                print("onAppear: isImageLoading = false")
                isImageLoading = false
                return
            }
            
            loadImage(urlString: urlString)
        }
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString)
        else {
            isImageLoading = false
            return
        }
        
        print("loadImage")
        
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

struct GridImageView: View {
    @Binding var image: UIImage?
    @Binding var isLoading: Bool
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 78, height: 78)
                .cornerRadius(10)
                .aspectRatio(contentMode: .fill)
        }
        else if isLoading {
            ProgressView()
        }
        else {
            Color.black
        }
    }
}


struct DetailGridItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailGridItem(placeMark: PlaceMarkEntity(context: CoreDataManager.shared.mainContext), PushDetailView: .constant(false))
    }
}

