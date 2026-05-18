//
//  BottomNavBar.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//

//  BottomNavBar.swift
//  Days-Since-Counter-iosapp

import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: Int = 0

    private let userID = "local-debug-user"

    var body: some View {
        let moodRepo = SwiftDataMoodRepository(context: modelContext)

        // Real service using your OpenAI API key from Secrets.xcconfig
        let aiService: any AIInsightService = OpenAIInsightService(apiKey: AppConfig.apiKey)

        let homeVM = HomeViewModel(
            moodRepo: moodRepo,
            aiService: aiService,
            userID: userID
        )

        let reportVM = ReportViewModel(
            moodRepo: moodRepo,
            userID: userID
        )

        ZStack {
            
            TabView(selection: $selectedTab) {
                HomeView(vm: homeVM, selectedTab: $selectedTab)
                    .tabItem { Label("Today", systemImage: "calendar") }
                    .tag(0)

                ChatView(aiService: aiService)
                    .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right") }
                    .tag(1)

                CounterView()
                    .tabItem { Label("No Contact", systemImage: "clock") }
                    .tag(2)
            }
            .tint(Color.brandPrimary)
            

            // If you later want to show the report overlay:
            // ReportView(vm: reportVM)
            //     .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

// MARK: - Stub AI service (safe until you wire OpenAI key)
private struct PreviewAIInsightService: AIInsightService {
    func generateMoodInsight(from input: MoodInsightInput) async throws -> String {
        "You're making progress—log a mood to see insights."
    }
    func generateChatResponse(conversation: [(isUser: Bool, text: String)]) async throws -> String {
        "I'm here for you. Take things one day at a time."
    }
}

#Preview {
    RootTabView()
        .modelContainer(for: [MoodEntry.self], inMemory: true)
}
