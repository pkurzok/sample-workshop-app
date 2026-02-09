//
//  LoginView.swift
//  SampleWorkshopApp
//
//  Created by Arnold Noronha on 2/9/26.
//

import SwiftUI
import DesignSystem

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State private var isLoggedIn = false
    @State var bannerMessage: String?
    @State var emailError: String?
    @State var passwordError: String?

    var body: some View {
        if isLoggedIn {
            SupportChatView(messages: SupportChatView.sampleMessages)
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
                    .foregroundStyle(AppTheme.accentGradient)

                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 40)

            // Error banner
            if let bannerMessage {
                ErrorBanner(bannerMessage)
                    .padding(.horizontal, AppTheme.horizontalPadding)
                    .padding(.bottom, 12)
            }

            // Input fields
            VStack(spacing: 16) {
                StyledTextField("Email", text: $email, hasError: emailError != nil, errorMessage: emailError)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                StyledTextField("Password", text: $password, isSecure: true, hasError: passwordError != nil, errorMessage: passwordError)
                    .textContentType(.password)
            }
            .padding(.horizontal, AppTheme.horizontalPadding)

            // Forgot password
            HStack {
                Spacer()
                Button("Forgot Password?") {}
                    .font(.footnote)
                    .padding(.top, 8)
                    .padding(.trailing, AppTheme.horizontalPadding)
            }

            // Sign in button
            PrimaryButton("Sign In") {
                attemptSignIn()
            }
            .padding(.horizontal, AppTheme.horizontalPadding)
            .padding(.top, 24)

            // Divider
            BrandedDivider()
                .padding(.horizontal, AppTheme.horizontalPadding)
                .padding(.vertical, 20)

            // Social sign-in buttons
            HStack(spacing: 16) {
                SocialButton(icon: "apple.logo", label: "Apple")
                SocialButton(icon: "g.circle.fill", label: "Google")
            }
            .padding(.horizontal, AppTheme.horizontalPadding)

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

    private func attemptSignIn() {
        bannerMessage = nil
        emailError = nil
        passwordError = nil

        if email.isEmpty && password.isEmpty {
            bannerMessage = "Please fill in all fields"
            emailError = "Email is required"
            passwordError = "Password is required"
        } else if email.isEmpty || !email.contains("@") {
            bannerMessage = "Please enter a valid email address"
            emailError = "Please enter a valid email address"
        } else if password.isEmpty {
            bannerMessage = "Password is required"
            passwordError = "Password is required"
        } else {
            isLoggedIn = true
        }
    }
}

#Preview("Default") {
    LoginView()
}

#Preview("Empty Fields Error") {
    LoginView(
        bannerMessage: "Please fill in all fields",
        emailError: "Email is required",
        passwordError: "Password is required"
    )
}

#Preview("Invalid Email Error") {
    LoginView(
        email: "bad-email",
        bannerMessage: "Please enter a valid email address",
        emailError: "Please enter a valid email address"
    )
}

#Preview("Missing Password Error") {
    LoginView(
        email: "user@example.com",
        bannerMessage: "Password is required",
        passwordError: "Password is required"
    )
}

#Preview("Filled In") {
    LoginView(email: "user@example.com", password: "password123")
}
