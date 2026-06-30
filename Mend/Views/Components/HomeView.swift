//
//  ContentView.swift
//  Mend
//
//  Created by Shehani Hansika on 05.05.26.
//

import SwiftUI
import SwiftData

// MARK: - Preview-only AI service (kept outside #Preview to avoid macro issues)
private struct PreviewAIInsightService: AIInsightService {
    func generateMoodInsight(from input: MoodInsightInput) async throws -> String {
        "Preview: Your mood today looks steady."
    }
    
    func generateChatResponse(conversation: [(isUser: Bool, text: String)]) async throws -> String {
        "Preview: I hear you. Take things one day at a time."
    }
}

struct HomeView: View {
    @AppStorage("userName") private var userName = "Friend"
    @AppStorage("profileImageData") private var profileImageData: Data = Data()
    @State private var showProfileSheet = false
    
    private let moods = [
        "Calm", "Sad", "Angry", "Anxious",
        "Okay", "Hopeful", "Tired", "Lonely", "Empty"
    ]
    
    @State private var vm: HomeViewModel
    @Binding var selectedTab: Int
    
    // MARK: - Greeting
    @State private var timeBasedGreeting: String = "Good morning"
    
    init(vm: HomeViewModel, selectedTab: Binding<Int>) {
        _vm = State(initialValue: vm)
        _selectedTab = selectedTab
    }
    
    private func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            timeBasedGreeting = "Good morning"
        case 12..<17:
            timeBasedGreeting = "Good afternoon"
        default:
            timeBasedGreeting = "Good evening"
        }
    }
    
    private var greetingText: String {
        let nameToDisplay = userName.isEmpty ? "Friend" : userName
        return "\(timeBasedGreeting), \(nameToDisplay)!"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundGradient
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        BlobAvatarView(
                            width: 150,
                            height: 160,
                            showShadow: true,
                            animate: true
                        )
                        .padding(.top, 2)
                        
                        Text(greetingText)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.brandPrimary)
                            .padding(.top, -20)
                        
                        Text("Let's unpack the day slowly... together.")
                            .font(.subheadline)
                            .foregroundStyle(Color.brandPrimary)
                            .padding(.top, -20)
                        
                        AffirmationView()
                            .padding(.horizontal, 22)
                        
                        MoodsSectionView(
                            moods: moods,
                            selectedMoods: $vm.selectedMoods,
                            notesText: $vm.notesText
                        ) { _ in
                            Task { await vm.apply() }
                        }
                        .padding(.horizontal)
                        
                        // AI loading row
                        if vm.isGeneratingTodayInsight {
                            HStack(spacing: 10) {
                                ProgressView()
                                Text("I’m here with you… just a moment.")
                                    .font(.footnote)
                                    .foregroundStyle(Color.brandPrimary)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // AI bubble
                        if let insight = vm.todayInsightText, !insight.isEmpty {
                            VStack(spacing: 4) {
                                AIInsightBubbleView(
                                    text: insight,
                                    avatarSystemImage: "person.crop.circle.fill"
                                )
                                
                                Button(action: {
                                    selectedTab = 1
                                }) {
                                    HStack(spacing: 4) {
                                        Text("Talk to me about it")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.caption)
                                    .foregroundStyle(Color.brandPrimary.opacity(0.7))
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 36)
                            }
                        }
                        
                        if let err = vm.lastError {
                            Text("Error: \(err)")
                                .font(.footnote)
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
                .scrollDismissesKeyboard(.interactively)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 110)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showProfileSheet = true
                        }) {
                            if !profileImageData.isEmpty, let uiImage = UIImage(data: profileImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.brandPrimary, lineWidth: 1)
                                    )
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .font(.title2)
                                    .foregroundStyle(Color.brandPrimary)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showProfileSheet) {
                    ProfileView()
                }
            }
            .onAppear {
                updateGreeting()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        dismissKeyboard()
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MoodEntry.self, configurations: config)
    let context = ModelContext(container)
    
    let repo = SwiftDataMoodRepository(context: context)
    
    let vm = HomeViewModel(
        moodRepo: repo,
        aiService: PreviewAIInsightService(),
        userID: "preview-user"
    )
    
    HomeView(vm: vm, selectedTab: .constant(0))
}
