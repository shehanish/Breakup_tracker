//
//  ContentView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 05.05.26.
//

import SwiftUI
import SwiftData

// MARK: - Preview-only AI service (kept outside #Preview to avoid macro issues)
private struct PreviewAIInsightService: AIInsightService {
    func generateMoodInsight(from input: MoodInsightInput) async throws -> String {
        "Preview: Your mood today looks steady. (Not medical advice.)"
    }
}

struct HomeView: View {
    private let moods = [
        "Calm", "Sad", "Angry", "Anxious",
        "Okay", "Hopeful", "Tired", "Lonely", "Empty"
    ]

    @State private var vm: HomeViewModel

    init(vm: HomeViewModel) {
        _vm = State(initialValue: vm)
    }

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

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    Image("bubu")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 150)
                        .padding(.top, 2)

                    Text("Good evening, Shehani!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.brandPrimary)
                        .padding(.top, -20)

                    Text("Let's unpack the day slowly.. together..")
                        .font(.subheadline)
                        .foregroundStyle(Color.brandPrimary)
                        .padding(.top, -20)

                    MoodsSectionView(
                        moods: moods,
                        selectedMoods: $vm.selectedMoods,
                        notesText: $vm.notesText
                    ) { _ in
                        Task { await vm.apply() }
                    }
                    .padding(.horizontal)
                    
                    //the ai Analays dialog box
                   if vm.isGeneratingTodayInsight {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Thinking…")
                                .font(.footnote)
                                .foregroundStyle(Color.brandPrimary)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if let insight = vm.todayInsightText {
                        AIInsightBubbleView(text: insight, avatarSystemImage: "person.crop.circle.fill")
                    }
                     //Debug View - Remove it later!!!
                    if let dbg = vm.lastSavedDebugText {
                        Text(dbg)
                            .font(.footnote)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding(.horizontal)
                    }
                    
                    if let err = vm.lastError {
                        Text("Error: \(err)")
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 80) // space above the tab bar
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MoodEntry.self, configurations: config)
    let context = ModelContext(container)

    let repo = SwiftDataMoodRepository(context: context)

    let vm = HomeViewModel(
        moodRepo: repo,
        aiService: PreviewAIInsightService(),
        userID: "preview-user"
    )

    HomeView(vm: vm)
}
