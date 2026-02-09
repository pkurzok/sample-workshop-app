//
//  LoginView.swift
//  SampleWorkshopApp
//
//  Created by Arnold Noronha on 2/9/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            ContentView()
        } else {
            loginContent
        }
    }

    private var loginContent: some View {
        VStack(spacing: 0) {
            Spacer()

            // App logo and title
            VStack(spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)

                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 40)

            // Input fields
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)

            // Forgot password
            HStack {
                Spacer()
                Button("Forgot Password?") {}
                    .font(.footnote)
                    .padding(.top, 8)
                    .padding(.trailing, 24)
            }

            // Sign in button
            Button {
                isLoggedIn = true
            } label: {
                Text("Sign In")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)

            // Divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.secondary.opacity(0.3))
                Text("or")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.secondary.opacity(0.3))
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)

            // Social sign-in buttons
            HStack(spacing: 16) {
                socialButton(icon: "apple.logo", label: "Apple")
                socialButton(icon: "g.circle.fill", label: "Google")
            }
            .padding(.horizontal, 24)

            Spacer()

            // Sign up prompt
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .foregroundStyle(.secondary)
                Button("Sign Up") {}
                    .fontWeight(.semibold)
            }
            .font(.footnote)
            .padding(.bottom, 24)
        }
    }

    private func socialButton(icon: String, label: String) -> some View {
        Button {} label: {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    LoginView()
}
