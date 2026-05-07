//
//  BottomNavBar.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        
            TabView {
                HomeView()
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
