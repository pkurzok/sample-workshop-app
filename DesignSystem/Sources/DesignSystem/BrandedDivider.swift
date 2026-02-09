import SwiftUI

public struct BrandedDivider: View {
    let text: String

    public init(_ text: String = "or") {
        self.text = text
    }

    public var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.secondary.opacity(0.3))
            Text(text)
                .font(.footnote)
                .foregroundStyle(.secondary)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.secondary.opacity(0.3))
        }
    }
}

#Preview("Light") {
    BrandedDivider()
        .padding()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    BrandedDivider()
        .padding()
        .preferredColorScheme(.dark)
}
