//
//  Persistence.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        for _ in 0..<10 {
            let comic = Favorite(context: controller.container.viewContext)
            comic.title = "Sina"
            comic.alt = "alt"
            comic.id = Int16(1)
            comic.image = Data()
            comic.date = "Oct 28, 2021"
            comic.explainURL = "https://shortcut.io" // =)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favorite")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveComic() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error occurs while saving comic: \(error.localizedDescription)")
            }
        }
    }
}
