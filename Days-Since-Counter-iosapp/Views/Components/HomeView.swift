//
//  ContentView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 05.05.26.
//

import SwiftUI
import SwiftData

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

                MoodsSectionView(moods: moods, selectedMoods: $vm.selectedMoods) { _ in
                                    // Only trigger VM action; VM owns logic now
                                    Task { await vm.apply() }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 30)

                                if let err = vm.lastError {
                                    Text("Error: \(err)")
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                        .padding(.horizontal)
                                }
                

            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MoodEntry.self, configurations: config)
    let context = ModelContext(container)

    let repo = SwiftDataMoodRepository(context: context)
    let vm = HomeViewModel(moodRepo: repo, userID: "preview-user")

    return HomeView(vm: vm)
}
