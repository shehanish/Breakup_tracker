//
//  ChatView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 18.05.26.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "I'm here to listen. What's on your mind?", isUser: false)
    ]
    @State private var inputText: String = ""

    var body: some View {
        ZStack {
            // Match the background gradient from HomeView
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

            VStack(spacing: 0) {
                // Header
                Text("Chat area")
                    .font(.headline)
                    .foregroundStyle(Color.brandPrimary)
                    .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack(spacing: 16) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        // Auto-scroll to bottom when new messages arrive
                        .onChange(of: messages.count) { _ in
                            if let last = messages.last {
                                withAnimation {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                // Input Area
                HStack(alignment: .bottom, spacing: 10) {
                    TextField("Type how you feel...", text: $inputText, axis: .vertical)
                        .padding(14)
                        .background(Color.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .lineLimit(1...5)

                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? Color.brandPrimary.opacity(0.5)
                                : Color.brandPrimary
                            )
                            .clipShape(Circle())
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
            }
            .padding(.bottom, 60) // Add bottom padding to account for TabBar
        }
    }

    private func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        // Add user message
        messages.append(ChatMessage(text: text, isUser: true))
        inputText = ""
        
        // Simulate AI thinking and replying for now
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            messages.append(ChatMessage(text: "Thanks for sharing. Take things one day at a time. I'm here. (AI Integration coming soon)", isUser: false))
        }
    }
}

// Separate view for individual chat bubbles
struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isUser {
                Spacer(minLength: 40)
                Text(message.text)
                    .padding(14)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    // Nice tailored corners for user message
                    .cornerRadius(4, corners: [.bottomRight])
            } else {
                Image("bubu") // Using the same avatar icon
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.4) 
                    .frame(width: 30, height: 30)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .padding(.bottom, 4)

                Text(message.text)
                    .padding(14)
                    .background(Color.white.opacity(0.85))
                    .foregroundColor(Color.black.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    // Nice tailored corners for AI message
                    .cornerRadius(4, corners: [.bottomLeft])
                Spacer(minLength: 40)
            }
        }
    }
}

// View extension to selectively round specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ChatView()
}
