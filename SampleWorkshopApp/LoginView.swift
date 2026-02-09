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
    @State var errorMessage: String?

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
            if let bannerText = errorBannerText {
                ErrorBanner(bannerText)
                    .padding(.horizontal, AppTheme.horizontalPadding)
                    .padding(.bottom, 12)
            }

            // Input fields
            VStack(spacing: 16) {
                StyledTextField("Email", text: $email, hasError: fieldHasError("email"), errorMessage: "Please enter a valid email address")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                StyledTextField("Password", text: $password, isSecure: true, hasError: fieldHasError("password"), errorMessage: "Password is required")
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
        if email.isEmpty && password.isEmpty {
            errorMessage = "emptyFields"
        } else if email.isEmpty || !email.contains("@") {
            errorMessage = "invalidEmail"
        } else if password.isEmpty {
            errorMessage = "missingPassword"
        } else {
            errorMessage = nil
            isLoggedIn = true
        }
    }

    private func fieldHasError(_ field: String) -> Bool {
        guard let error = errorMessage else { return false }
        switch field {
        case "email":
            return error == "emptyFields" || error == "invalidEmail"
        case "password":
            return error == "emptyFields" || error == "missingPassword"
        default:
            return false
        }
    }

    private var errorBannerText: String? {
        guard let error = errorMessage else { return nil }
        switch error {
        case "emptyFields": return "Please fill in all fields"
        case "invalidEmail": return "Please enter a valid email address"
        case "missingPassword": return "Password is required"
        default: return nil
        }
    }
}

#Preview("Default") {
    LoginView()
}

#Preview("Empty Fields Error") {
    LoginView(errorMessage: "emptyFields")
}

#Preview("Invalid Email Error") {
    LoginView(email: "bad-email", errorMessage: "invalidEmail")
}

#Preview("Missing Password Error") {
    LoginView(email: "user@example.com", errorMessage: "missingPassword")
}

#Preview("Filled In") {
    LoginView(email: "user@example.com", password: "password123")
}
