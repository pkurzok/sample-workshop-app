import SwiftUI

public struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var hasError: Bool = false
    var errorMessage: String?

    public init(_ placeholder: String, text: Binding<String>, isSecure: Bool = false, hasError: Bool = false, errorMessage: String? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.hasError = hasError
        self.errorMessage = errorMessage
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding()
            .background(AppTheme.cardBackground)
            .cornerRadius(AppTheme.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                    .stroke(hasError ? .red : .clear, lineWidth: 1.5)
            )

            if hasError, let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.leading, 4)
            }
        }
    }
}

#Preview("Default") {
    StyledTextField("Email", text: .constant(""))
        .padding()
}

#Preview("With Error") {
    StyledTextField("Email", text: .constant("bad"), hasError: true, errorMessage: "Please enter a valid email")
        .padding()
}
