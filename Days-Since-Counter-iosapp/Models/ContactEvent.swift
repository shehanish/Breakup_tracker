//
//  ContactEvent.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 09.05.26.
//


import Foundation
import SwiftData

@Model
final class ContactEvent {
    var userID: String
    var id: UUID
    var timestamp: Date

    init(userID: String, id: UUID = UUID(), timestamp: Date = .now) {
        self.userID = userID
        self.id = id
        self.timestamp = timestamp
    }
}