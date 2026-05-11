//
//  MoodCount.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 11.05.26.
//


import Foundation

struct MoodCount: Identifiable, Hashable {
    let mood: String
    let count: Int

    var id: String { mood }   // stable id per mood
}