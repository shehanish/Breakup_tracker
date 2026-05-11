//
//  BottomNavBar.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        // Create dependencies once per body evaluation (ok for now)
        let moodRepo = SwiftDataMoodRepository(context: modelContext)
        let homeVM = HomeViewModel(moodRepo: moodRepo, userID: "local-debug-user")

        TabView {
            HomeView(vm: homeVM)
                .tabItem { Label("Home", systemImage: "house") }

            CounterView()
                .tabItem { Label("Settings", systemImage: "gear") }

            Text("Profile")
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    RootTabView()
        .modelContainer(for: [MoodEntry.self], inMemory: true)
}
