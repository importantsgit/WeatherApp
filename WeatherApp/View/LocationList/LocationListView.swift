//
//  DetailView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/06.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var manager: CoreDataManager
    @State private var keyword = ""
    @State private var pushDetailView = false
    @State private var pushListEditView = false
    
    @Binding var location: [String?]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\PlaceMarkEntity.title, order: .reverse)])
    var placeList: FetchedResults<PlaceMarkEntity>
    
    @State private var sortByDateDesc = true
    
    private let columns = [GridItem(alignment: .center)]
    
    func delete(set: IndexSet) {
        for index in set {
            manager.delete(placeMark: placeList[index])
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(placeList) { item in
                    NavigationLink(destination: DetailView(placeMark: item, location: location)) {
                        DetailGridItem(placeMark: item, PushDetailView: $pushDetailView)
                            .listRowBackground(Color("backgroundColor"))
                            .listRowSeparatorTint(.white)
                            .listRowInsets(EdgeInsets())
                            .padding(.leading, 16)
                    }
                    .listRowBackground(Color("backgroundColor"))
                    .listRowSeparator(Visibility.hidden)
                    .listStyle(PlainListStyle())
                }
                .onDelete(perform: delete)
            }
            .searchable(text: $keyword, placement: .navigationBarDrawer, prompt: "찾으시는 제목을 입력하세요")
            .frame(width: geometry.size.width, height: geometry.size.height)
            .scrollContentBackground(.hidden)
            .background {
                Color("backgroundColor")
                    .ignoresSafeArea()
            }
            .overlay {
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        ListEditView()
                        
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 54, height: 54)
                            .foregroundColor(.white)
                            .background(Color(hex: "2B2B2B"))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }

            }
            .onChange(of: keyword) { newValue in
                if newValue.isEmpty {
                    placeList.nsPredicate = nil // 저장된 전체 메모가 표시
                } else {
                    placeList.nsPredicate = NSPredicate(format: "title CONTAINS[c] %@", newValue)
                }
            }
            .onChange(of: sortByDateDesc) { desc in
                if desc {
                    placeList.sortDescriptors = [
                        SortDescriptor(\.title, order: .reverse)]
                } else {
                    placeList.sortDescriptors = [
                        SortDescriptor(\.title, order: .forward)]
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(location[0] ?? "")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "3A3A3A"))
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        sortByDateDesc.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .tint(Color(hex: "3A3A3A"))
                    }
                    
                    EditButton()
                        .tint(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }


    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationListView(location: .constant(["강원", "거의"]))
                .environmentObject(CoreDataManager.shared)
        }
    }
}
