//
//  xkcdApp.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

@main
struct xkcdApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
