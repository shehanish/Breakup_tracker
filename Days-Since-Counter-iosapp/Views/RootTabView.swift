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

    // Keep VMs in State so they are only created once and don't leak memory on re-renders
    @State private var homeVM: HomeViewModel?
    @State private var chatVM: ChatViewModel?

    private let userID = "local-debug-user"

    var body: some View {
        ZStack {
            if let homeVM = homeVM, let chatVM = chatVM {
                TabView(selection: $selectedTab) {
                    HomeView(vm: homeVM, selectedTab: $selectedTab)
                        .tabItem { Label("Today", systemImage: "calendar") }
                        .tag(0)

                    ChatView(vm: chatVM)
                        .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right") }
                        .tag(1)

                    CounterView()
                        .tabItem { Label("No Contact", systemImage: "clock") }
                        .tag(2)
                }
                .tint(Color.brandPrimary)
            } else {
                ProgressView() // Show loading until VMs initialize
            }
        }
        .onAppear {
            setupViewModels()
        }
    }
    
    private func setupViewModels() {
        // Only initialize once to prevent memory leaks
        guard homeVM == nil else { return }
        
        let moodRepo = SwiftDataMoodRepository(context: modelContext)
        let aiService: any AIInsightService = OpenAIInsightService(apiKey: AppConfig.apiKey)

        homeVM = HomeViewModel(
            moodRepo: moodRepo,
            aiService: aiService,
            userID: userID
        )
        
        chatVM = ChatViewModel(aiService: aiService)
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
