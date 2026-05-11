//
//  HomeViewViewModel.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 11.05.26.
//


import Foundation
import Observation

@Observable
final class HomeViewModel{
    
    private let moodRepo: any MoodRepository
    private let userID: String
    
    var selectedMoods: Set<String> = []
    var lastError: String?
    
    init(moodRepo: any MoodRepository, userID: String) {
            self.moodRepo = moodRepo
            self.userID = userID
        }
    
    // Derived UI state
        var canApply: Bool {
            !selectedMoods.isEmpty
        }

        // User action
        func apply() async {
            let applied = Array(selectedMoods).sorted()

            do {
                try await moodRepo.addMoodEntry(
                    userID: userID,
                    moods: applied,
                    timestamp: .now
                )

                // Clear selection after successful save
                selectedMoods.removeAll()
                lastError = nil
            } catch {
                lastError = String(describing: error)
            }
        }
    }

