//
//  MoodsSectionView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import SwiftUI

struct MoodsSectionView: View {
    let moods: [String]
    @Binding var selectedMoods: Set<String>

    // NEW: bind the note text
    @Binding var notesText: String

    var onApply: (_ appliedMoods: [String]) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("How are you feeling?")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .foregroundStyle(Color.brandPrimary)

            MoodPicker(moods: moods, selectedMoods: $selectedMoods)

            VStack(spacing: 12) {
                SelectedMoodsBox(selectedMoods: Array(selectedMoods).sorted())
                    .frame(maxWidth: 420)
                    .frame(maxWidth: .infinity, alignment: .center)

                // NEW: Note box under selected moods box
                VStack(alignment: .leading, spacing: 8) {
                    Text("Want to add a note?")
                        .font(.subheadline)
                        .foregroundStyle(Color.brandPrimary)

                    TextField("Type how you feel in words…", text: $notesText, axis: .vertical)
                        .lineLimit(3...6)
                        .padding(12)
                        .background(.white.opacity(0.55))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.brandPrimary.opacity(0.20), lineWidth: 1)
                        )
                }

                Button {
                    onApply(Array(selectedMoods).sorted())
                    print("APPLY tapped. selectedMoods =", Array(selectedMoods).sorted())
                } label: {
                    Text("Apply")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.brandPrimary)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.lavender.opacity(0.8))
                
            }
            .padding(.horizontal)
        }
    }
}
#Preview {
    MoodsSectionViewPreviewWrapper()
}

private struct MoodsSectionViewPreviewWrapper: View {
    private let moods = [
        "Calm", "Sad", "Angry", "Anxious",
        "Okay", "Hopeful", "Tired", "Lonely", "Empty"
    ]

    @State private var selectedMoods: Set<String> = ["Calm", "Tired"]
    @State private var notesText: String = "I felt a bit overwhelmed today, but better now."

    var body: some View {
        MoodsSectionView(
            moods: moods,
            selectedMoods: $selectedMoods,
            notesText: $notesText
        ) { applied in
            print("Preview Apply tapped:", applied, "notes:", notesText)
        }
        .padding()
    }
}
