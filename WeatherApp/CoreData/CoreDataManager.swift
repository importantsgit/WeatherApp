//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/11.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WeatherApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addMemo(content: PlaceMark) {
        let placeMark = PlaceMarkEntity(context: mainContext)
        placeMark.title = content.title
        placeMark.body = content.description
        placeMark.phoneNumber = Int16(content.phoneNumber) ?? 0
        placeMark.tag = content.tag
        // TODO: 이미지 저장
        
        saveContext()
    }
    
    func update(placeMark: PlaceMarkEntity?, content: PlaceMark) {
        placeMark?.title = content.title
        placeMark?.body = content.description
        placeMark?.phoneNumber = Int16(content.phoneNumber) ?? 0
        placeMark?.tag = content.tag
        saveContext()
    }
    
    func delete(placeMark: PlaceMarkEntity?) {
        if let placeMark = placeMark {
            mainContext.delete(placeMark)
            saveContext()
        }
    }
}
