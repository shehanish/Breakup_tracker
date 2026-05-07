//
//  MoodEntry.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import Foundation

struct MoodEntry: Identifiable {
    let id = UUID()
    let date: Date
    let moods: [String]
}