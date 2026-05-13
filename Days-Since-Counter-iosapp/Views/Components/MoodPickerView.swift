//
//  MoodPicker.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import SwiftUI

struct MoodPickerView: View {
    let moods: [String] = ["Calm", "Sad", "Angry", "Anxious", "Okay", "Hopeful", "Tired", "Lonely", "Empty"]
    @Binding var selectedMoods: Set<String>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(moods, id: \.self) { mood in
                    let isSelected = selectedMoods.contains(mood)

                    Button {
                        withAnimation(.snappy) {
                            if isSelected {
                                selectedMoods.remove(mood)
                            } else {
                                selectedMoods.insert(mood)
                            }
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text(mood)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.brandPrimary)

                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .foregroundStyle(isSelected ? .black : .primary)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(isSelected ? Color.lavender.opacity(0.75) : Color.white.opacity(0.6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(Color.lavender.opacity(0.08), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }
}

