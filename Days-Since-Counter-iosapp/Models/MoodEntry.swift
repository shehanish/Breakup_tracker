//
//  MoodEntry.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import Foundation
import SwiftData

@Model
final class MoodEntry {
    var userID: String
    var id: UUID
    var timestamp: Date
    var moods: [String]
    
    init(userID: String, id: UUID = UUID(), timestamp: Date = .now, moods: [String] = []) {
        self.userID = userID
        self.id = id
        self.timestamp = timestamp
        self.moods = moods
    }
}
