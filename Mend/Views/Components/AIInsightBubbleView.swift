//
//  AIInsightBubbleView.swift
//  Mend
//
//  Created by Shehani Hansika on 13.05.26.
//


import SwiftUI

struct AIInsightBubbleView: View {
    let text: String
    var avatarSystemImage: String = "IMG_3016"

    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            BlobAvatarView(width: 36, height: 30, showShadow: false)

            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color.textOnPrimary)
                .padding(12)
                .background(Color.white.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.brandPrimary.opacity(0.35), lineWidth: 1)
                       
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: 350, alignment: .leading)
        .padding(.horizontal)
    }
}


