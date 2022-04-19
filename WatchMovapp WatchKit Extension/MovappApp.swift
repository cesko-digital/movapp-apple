//
//  MovappApp.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 13.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                RootContentView()
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
