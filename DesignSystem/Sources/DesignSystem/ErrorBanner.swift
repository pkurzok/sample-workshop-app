import SwiftUI

public struct ErrorBanner: View {
    let message: String

    public init(_ message: String) {
        self.message = message
    }

    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(message)
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(AppTheme.errorGradient)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: .red.opacity(0.2), radius: 6, y: 3)
    }
}

#Preview("Light") {
    ErrorBanner("Please fill in all fields")
        .padding()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ErrorBanner("Please fill in all fields")
        .padding()
        .preferredColorScheme(.dark)
}
