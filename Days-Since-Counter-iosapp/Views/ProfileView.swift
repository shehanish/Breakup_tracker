//
//  ProfileView.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//


import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("userName") var userName = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var editName: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundGradient.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Avatar
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.brandPrimary)
                            .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Name")
                                .font(.headline)
                                .foregroundStyle(Color.textOnPrimary)
                            
                            TextField("Enter your name", text: $editName)
                                .textInputAutocapitalization(.words)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action: {
                            userName = editName
                            dismiss()
                        }) {
                            Text("Save Profile")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.brandPrimary)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer(minLength: 50)
                        
                        Button(action: {
                            // Sign out logic
                            isLoggedIn = false
                            dismiss()
                        }) {
                            Text("Sign Out")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .foregroundStyle(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(Color.brandPrimary)
                }
            }
            .onAppear {
                editName = userName
            }
        }
    }
}

#Preview {
    ProfileView()
}