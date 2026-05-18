//
//  ChatMessage.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 18.05.26.
//

import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
