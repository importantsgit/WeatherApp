//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct LocationListView: View {
    @ObservedObject var service = DetailListService()
    @State private var keyword = ""
    @State private var pushDetailView = false
    @State private var pushListEditView = false
    
    @Binding var location: [String?]
    
    
    
    private let columns = [GridItem(alignment: .center)]
    
    var body: some View {
        List {
            ForEach(service.placeMark) { item in
                DetailGridItem(placeMark: item, PushDetailView: $pushDetailView)
                    .listRowBackground(Color("backgroundColor"))
                    .listRowSeparatorTint(.white)
                    .listRowInsets(EdgeInsets())
                    .padding(.leading, 16)
            }
            .onDelete { rows in
                service.placeMark.remove(atOffsets: rows)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            Button {
                pushListEditView = true
            } label: {
                Image(systemName: "plus")
                    .frame(width: 54, height: 54)
                    .foregroundColor(.white)
                    .background(Color(hex: "2B2B2B"))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
        .background {
            Color("backgroundColor")
                .ignoresSafeArea()
        }
        .searchable(text: $keyword, placement: .navigationBarDrawer, prompt: "찾으시는 제목을 입력하세요") {
            
        }
        .onSubmit(of: .search) {
            if keyword.count > 0 {
                service.placeMark = service.placeMark.filter {
                    $0.title.contains(keyword)
                }
            } else {
                service.placeMark = service.placeMark
            }
        }
        .onChange(of: keyword) { newValue in
            if newValue.count == 0 {
                service.placeMark = service.placeMark
            }
        }
        .navigationDestination(isPresented: $pushDetailView) {
            DetailView()
        }
        .navigationDestination(isPresented: $pushListEditView) {
            ListEditView(service: service)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(location[0] ?? "")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(hex: "3A3A3A"))
            }
        }
        .toolbar{
            EditButton()
                .tint(.black)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationListView(service: DetailListService.preview, location: .constant(["강원", "거의"]))
        }
    }
}
