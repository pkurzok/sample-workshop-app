//
//  LoginView.swift
//  SampleWorkshopApp
//
//  Created by Arnold Noronha on 2/9/26.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State private var isLoggedIn = false
    @State var errorMessage: String?

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

            // Error banner
            if let bannerText = errorBannerText {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text(bannerText)
                }
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.red.gradient)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }

            // Input fields
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(fieldHasError("email") ? .red : .clear, lineWidth: 1)
                        )

                    if fieldHasError("email") {
                        Text("Please enter a valid email address")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .padding(.leading, 4)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(fieldHasError("password") ? .red : .clear, lineWidth: 1)
                        )

                    if fieldHasError("password") {
                        Text("Password is required")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .padding(.leading, 4)
                    }
                }
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
                attemptSignIn()
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
