//
//  MoodSwiftDataTest.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 09.05.26.
//

import SwiftUI
import SwiftData

struct MoodSwiftDataTestView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var count: Int = 0
    @State private var latestText: String = "None"
    @State private var lastError: String?

    private let testUserID = "local-debug-user"

    var body: some View {
        NavigationStack {
            List {
                Section("Insert") {
                    Button("Insert 1 MoodEntry") {
                        insertMoodEntry()
                    }
                }

                Section("Fetch") {
                    Button("Fetch MoodEntries (sorted) + print") {
                        fetchMoodEntries()
                    }
                }

                Section("Status") {
                    Text("MoodEntry count: \(count)")
                    Text("Latest entry: \(latestText)")
                    if let lastError {
                        Text("Last error: \(lastError)")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Mood DB Test")
        }
    }
}

extension MoodSwiftDataTestView {
    func insertMoodEntry() {
        let entry = MoodEntry(
            userID: testUserID,
            moods: ["Calm", "Hopeful"]   // hard-coded for testing
        )

        modelContext.insert(entry)

        do {
            try modelContext.save()
            print("✅ Inserted MoodEntry id=\(entry.id) moods=\(entry.moods) time=\(entry.timestamp)")
            lastError = nil
        } catch {
            print("❌ Save failed:", error)
            lastError = String(describing: error)
        }
    }

    func fetchMoodEntries() {
        do {
            let descriptor = FetchDescriptor<MoodEntry>(
                sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
            )

            let results = try modelContext.fetch(descriptor)
            count = results.count

            if let latest = results.first {
                latestText = "\(latest.timestamp.formatted()) — \(latest.moods.joined(separator: ", "))"
            } else {
                latestText = "None"
            }

            print("✅ Fetched \(results.count) MoodEntry rows")
            lastError = nil
        } catch {
            print("❌ Fetch failed:", error)
            lastError = String(describing: error)
        }
    }
}

#Preview {
    MoodSwiftDataTestView()
        .modelContainer(for: [MoodEntry.self], inMemory: true)
}
