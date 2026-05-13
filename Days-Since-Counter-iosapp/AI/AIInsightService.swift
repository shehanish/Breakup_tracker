//
//  AIInsightService.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 12.05.26.
//


import Foundation

protocol AIInsightService {
    func generateMoodInsight(from input: MoodInsightInput) async throws -> String
}