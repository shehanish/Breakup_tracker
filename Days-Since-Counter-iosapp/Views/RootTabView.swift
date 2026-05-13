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

    private let userID = "local-debug-user"

    var body: some View {
        let moodRepo = SwiftDataMoodRepository(context: modelContext)

        // Real service (reads key from environment / config if you have one).
        // If you don't have a key yet, use the stub below.
        let aiService: any AIInsightService = PreviewAIInsightService()

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
            TabView {
                HomeView(vm: homeVM)
                    .tabItem { Label("Today", systemImage: "calendar") }

                Text("Chat")
                    .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right") }

                CounterView()
                    .tabItem { Label("No Contact", systemImage: "clock") }
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
        "You're making progress—log a mood to see insights. (Not medical advice.)"
    }
}

#Preview {
    RootTabView()
        .modelContainer(for: [MoodEntry.self], inMemory: true)
}
