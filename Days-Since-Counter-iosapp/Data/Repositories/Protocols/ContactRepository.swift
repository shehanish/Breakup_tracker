//
//  ContactRepository.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 09.05.26.
//


import Foundation

protocol ContactRepository {
    func addContactEvent(userID: String, timestamp: Date) async throws

    func fetchLatestContactEvent(userID: String) async throws -> ContactEvent?
}