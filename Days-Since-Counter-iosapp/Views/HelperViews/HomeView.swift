//
//  ContentView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 05.05.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    private let period = ["30 Days", "60 Days", "90 Days", "Custom"]

    private let moods = [
        "Calm", "Sad", "Angry", "Anxious",
        "Okay", "Hopeful", "Tired", "Lonely"
    ]

    let moodRepo: any MoodRepository   // ✅ injected dependency

    @State private var selectedMoods: Set<String> = []
    @State private var appliedMoods: [String] = []
    @State private var moodHistory: [MoodEntry] = []   // you can remove this for now if unused
    @State private var lastError: String?

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.88, blue: 0.94),
                    Color(red: 0.92, green: 0.85, blue: 0.97),
                    Color(red: 0.88, green: 0.82, blue: 0.96)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Image("feelings")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding(.top, -220)

                Text("Good evening, Shehani!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -50)
                    .foregroundStyle(Color.brandPrimary)

                Text("Let's unpack the day slowly.. together..")
                    .font(.subheadline)
                    .padding(.top, -30)
                    .foregroundStyle(Color.brandPrimary)

                MoodsSectionView(moods: moods, selectedMoods: $selectedMoods) { applied in
                    // snapshot of what user applied
                    appliedMoods = applied

                    Task {
                        do {
                            try await moodRepo.addMoodEntry(
                                userID: "local-debug-user",
                                moods: applied,
                                timestamp: .now
                            )
                            lastError = nil
                            selectedMoods.removeAll()
                            print("✅ Saved via repository:", applied)
                        } catch {
                            lastError = String(describing: error)
                            print("❌ Repository save failed:", error)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)

                if let lastError {
                    Text("Error: \(lastError)")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: MoodEntry.self)
    let context = ModelContext(container)
    let repo = SwiftDataMoodRepository(context: context)
    return HomeView(moodRepo: repo)
}
