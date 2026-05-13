//
//  HomeViewViewModel.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 11.05.26.
//


import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {

    private let moodRepo: any MoodRepository
    private let aiService: AIInsightService
    private let userID: String
    private let calendar: Calendar

    // Ephemeral UI state
    var selectedMoods: Set<String> = []

    // AI insight UI state (today)
    var todayInsightText: String?
    var isGeneratingTodayInsight: Bool = false

    // Error state (repo or AI)
    var lastError: String?

    init(
        moodRepo: any MoodRepository,
        aiService: AIInsightService,
        userID: String,
        calendar: Calendar = .current
    ) {
        self.moodRepo = moodRepo
        self.aiService = aiService
        self.userID = userID
        self.calendar = calendar
    }

    // Derived UI state
    var canApply: Bool { !selectedMoods.isEmpty }

    // User action: save mood entry
    func apply() async {
        let applied = Array(selectedMoods).sorted()

        do {
            try await moodRepo.addMoodEntry(
                userID: userID,
                moods: applied,
                timestamp: .now
            )

            selectedMoods.removeAll()
            lastError = nil

            // Refresh today's insight after logging
            await generateInsightForToday()
        } catch {
            lastError = String(describing: error)
        }
    }

    /// Generates a 1–3 sentence insight based only on mood entries logged today.
    func generateInsightForToday() async {
        guard !isGeneratingTodayInsight else { return }

        isGeneratingTodayInsight = true
        defer { isGeneratingTodayInsight = false }

        do {
            let now = Date()
            let startOfToday = calendar.startOfDay(for: now)

            let entries = try await moodRepo.fetchMoodEntries(
                userID: userID,
                from: startOfToday,
                to: now
            )

            // Aggregate today's moods
            var counts: [String: Int] = [:]
            for entry in entries {
                for mood in entry.moods {
                    counts[mood, default: 0] += 1
                }
            }

            // If no moods logged today, you can show a local message (no AI call)
            guard !counts.isEmpty else {
                todayInsightText = "Log your mood to get a short reflection here. (Not medical advice.)"
                lastError = nil
                return
            }

            let input = MoodInsightInput(
                startDate: startOfToday,
                endDate: now,
                moodCounts: counts
            )

            todayInsightText = try await aiService.generateMoodInsight(from: input)
            lastError = nil
        } catch {
            lastError = String(describing: error)
        }
    }
}
