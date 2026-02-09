import SwiftUI

public enum AppTheme {
    // Brand gradient — indigo to blue
    public static let accentGradient = LinearGradient(
        colors: [Color.indigo, Color.blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    public static let errorGradient = LinearGradient(
        colors: [Color.red, Color.pink],
        startPoint: .leading,
        endPoint: .trailing
    )

    public static let cornerRadius: CGFloat = 14
    public static let horizontalPadding: CGFloat = 24

    public static let cardBackground = Color(.secondarySystemBackground)
}
