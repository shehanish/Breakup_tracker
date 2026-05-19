import SwiftUI

struct AuthView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("userName") var userName = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var isSignUp = true
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundGradient
                    .ignoresSafeArea(.all, edges: .all)
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text(isSignUp ? "Create Account" : "Welcome Back")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.textOnPrimary)
                            .padding(.top, 40)
                        
                        VStack(spacing: 15) {
                            if isSignUp {
                                TextField("Name", text: $name)
                                    .textInputAutocapitalization(.words)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            if isSignUp {
                                SecureField("Confirm Password", text: $confirmPassword)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action: {
                            // Save name if sign up
                            if isSignUp && !name.isEmpty {
                                userName = name
                            } else if userName.isEmpty {
                                // If sign in without an existing name, put a fallback
                                userName = "Friend"
                            }
                            
                            // For now this is dummy login logic allowing any credentials to log in.
                            isLoggedIn = true
                            dismiss()
                        }) {
                            Text(isSignUp ? "Sign Up" : "Sign In")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.brandPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                        
                        Button(action: {
                            withAnimation {
                                isSignUp.toggle()
                            }
                        }) {
                            Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                                .font(.subheadline)
                                .foregroundStyle(Color.brandPrimary)
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(Color.brandPrimary)
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
