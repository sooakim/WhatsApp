//
//  whatsappApp.swift
//  whatsapp
//
//  Created by 김수아 on 1/12/24.
//

import SwiftUI
import Kingfisher
import WANetworkAPI

@main
struct whatsappApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.store, StoreEnvironment())
                .task{
                    KingfisherManager.shared.defaultOptions = [.requestModifier(AuthorizationPlugin())]
                }
        }
    }
}

struct AuthorizationPlugin: ImageDownloadRequestModifier{
    
    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        if let token = NetworkAPI.User.token{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
