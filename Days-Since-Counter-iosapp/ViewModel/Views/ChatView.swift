//
//  ChatView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 18.05.26.
//

import SwiftUI

struct ChatView: View {
    @State private var vm: ChatViewModel

    init(vm: ChatViewModel) {
        _vm = State(initialValue: vm)
    }

    var body: some View {
        ZStack {
            // Match the background gradient from HomeView
            Color.appBackgroundGradient
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
                            ForEach(vm.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        // Auto-scroll to bottom when new messages arrive
                        .onChange(of: vm.messages.count) { _ in
                            if let last = vm.messages.last {
                                withAnimation {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                if vm.isThinking {
                    HStack {
                        Image("bubu")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.4) 
                            .frame(width: 30, height: 30)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .padding(.bottom, 4)
                        
                        Text("typing...")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.85))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                }
                
                // Input Area
                HStack(alignment: .bottom, spacing: 10) {
                    TextField("Type how you feel...", text: $vm.inputText, axis: .vertical)
                        .padding(14)
                        .background(Color.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .lineLimit(1...5)
                        .autocorrectionDisabled()

                    Button(action: {
                        Task { await vm.sendMessage() }
                    }) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? Color.brandPrimary.opacity(0.3)
                                : Color.brandPrimary
                            )
                            .clipShape(Circle())
                    }
                    .disabled(vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 4)
            }
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
                    .background(Color.sageGreen.opacity(0.15))
                    .foregroundColor(Color.textOnPrimary)
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
    // Basic preview stub
    struct PreviewService: AIInsightService {
        func generateMoodInsight(from input: MoodInsightInput) async throws -> String { "Stub" }
        func generateChatResponse(conversation: [(isUser: Bool, text: String)]) async throws -> String { "Stub reply" }
    }
    
    let vm = ChatViewModel(aiService: PreviewService())
    return ChatView(vm: vm)
}
