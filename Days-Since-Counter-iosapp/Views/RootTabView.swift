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
        
        //MoodSwiftDataTestView()
            //.modelContainer(for: [MoodEntry.self], inMemory: true)
        let moodRepo = SwiftDataMoodRepository(context: modelContext)
        
         TabView {
             HomeView(moodRepo: moodRepo)
         .tabItem { Label("Home", systemImage: "house") }
         Spacer()
         CounterView()
         .tabItem {
         Image(systemName: "gear")
         Text("Settings")
         
         }
         Spacer()
         Text("Profile")
         .tabItem {
         Image(systemName: "person")
         Text("Profile")
         
         }
         }
         
         
    }
}

#Preview {
    RootTabView()
}
