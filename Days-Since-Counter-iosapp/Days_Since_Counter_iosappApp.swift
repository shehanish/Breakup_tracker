//
//  Days_Since_Counter_iosappApp.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 05.05.26.
//

import SwiftUI
import SwiftData

@main
struct Days_Since_Counter_iosappApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for:
            [MoodEntry.self]
        )
        
    }
}
