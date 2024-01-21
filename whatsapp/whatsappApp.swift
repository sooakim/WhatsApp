//
//  whatsappApp.swift
//  whatsapp
//
//  Created by 김수아 on 1/12/24.
//

import SwiftUI

@main
struct whatsappApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.store, StoreEnvironment())
        }
    }
}
