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
                Image("kalito 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, -100)

                Text("You can do this!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(spacing: 20) {
                    DatePicker("Start Date",
                               selection: $selectedDate,
                               displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(maxWidth: 380)

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
