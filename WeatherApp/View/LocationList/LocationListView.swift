//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var manager: CoreDataManager
    @ObservedObject var service = DetailListService()
    @State private var keyword = ""
    @State private var pushDetailView = false
    @State private var pushListEditView = false
    
    @Binding var location: [String?]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\PlaceMarkEntity.title, order: .reverse)])
    var placeList: FetchedResults<PlaceMarkEntity>
    
    private let columns = [GridItem(alignment: .center)]
    
    var body: some View {
        List {
            ForEach(service.placeMark) { item in
                DetailGridItem(placeMark: item, PushDetailView: $pushDetailView)
                    .listRowBackground(Color("backgroundColor"))
                    .listRowSeparatorTint(.white)
                    .listRowInsets(EdgeInsets())
                    .padding(.leading, 16)
                    .navigationDestination(isPresented: $pushDetailView) {
                        DetailView(placeMark: item, location: location)
                    }
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
            if keyword.isEmpty {
                placeList.nsPredicate = nil // 저장된 전체 메모가 표시
            } else {
                placeList.nsPredicate = NSPredicate(format: "content CONTAINS[c] %@", newValue)
            }
            if newValue.count == 0 {
                service.placeMark = service.placeMark
            }
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
                .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
        }
    }
}
