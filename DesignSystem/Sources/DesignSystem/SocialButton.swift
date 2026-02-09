import SwiftUI

public struct SocialButton: View {
    let icon: String
    let label: String

    public init(icon: String, label: String) {
        self.icon = icon
        self.label = label
    }

    public var body: some View {
        Button {} label: {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppTheme.cardBackground)
            .cornerRadius(AppTheme.cornerRadius)
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        SocialButton(icon: "apple.logo", label: "Apple")
        SocialButton(icon: "g.circle.fill", label: "Google")
    }
    .padding()
}
