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

                Button {
                    onApply(Array(selectedMoods).sorted())
                    //Debug
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
                .disabled(selectedMoods.isEmpty)
                .opacity(selectedMoods.isEmpty ? 0.5 : 1.0)
            }
            .padding(.horizontal)
        }
    }
}
