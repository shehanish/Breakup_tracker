//
//  AppConfig.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 12.05.26.
//


import Foundation

enum AppConfig {
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "MY_API_KEY") as? String,
              !key.isEmpty,
              !key.contains("put-your-key-here")
        else {
            fatalError("Missing MY_API_KEY. Check Secrets.xcconfig and Info.plist.")
        }
        return key
    }
}