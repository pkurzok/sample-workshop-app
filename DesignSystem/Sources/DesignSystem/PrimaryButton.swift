import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppTheme.accentGradient)
                .foregroundStyle(.white)
                .cornerRadius(AppTheme.cornerRadius)
                .shadow(color: .indigo.opacity(0.3), radius: 8, y: 4)
        }
    }
}

#Preview {
    PrimaryButton("Sign In") {}
        .padding()
}
