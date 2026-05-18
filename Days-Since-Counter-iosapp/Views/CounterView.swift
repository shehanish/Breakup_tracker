//
//  SettingsView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import SwiftUI

struct CounterView: View {
    private let period = ["30 Days", "60 Days", "90 Days", "Custom"]

    @State private var selectedPeriod: String?
    @State private var selectedDate: Date = .now

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.88, blue: 0.94),
                    Color(red: 0.92, green: 0.85, blue: 0.97),
                    Color(red: 0.88, green: 0.82, blue: 0.96)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
               
                Text("You can do this!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Debug text so the user can verify the API key is injected!
                Text("API Key Loaded: \(AppConfig.apiKey == "put-your-key-here" ? "Wait, it's the example key!" : "Yes, secret key is loaded!")")
                    .font(.footnote)
                    .foregroundColor(.gray)

                VStack(spacing: 20) {
                    DatePicker("Start Date",
                               selection: $selectedDate,
                               displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    DropDownView(title: "I go for...",
                                 prompt: "1 Week",
                                 options: period,
                                 selection: $selectedPeriod)
            
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
           // slight breathing room above tab bar
        }
    }
}

#Preview {
    CounterView()
}
