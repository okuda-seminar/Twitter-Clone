import SwiftUI

struct MessagesSettingsHomeReadReceiptsSectionView: View {
  private enum LayoutConstant {
    static let toggleTrailingPadding: CGFloat = 2.0
    static let toggleTopPadding: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let readReceiptsOptionTitle = String(localized: "Show read receipts")
    static let readReceiptsOptionCaption = String(
      localized:
        "Let people you're messaging with know when you've seen their messages.\n\nRead receipts are not shown on message requests."
    )
    static let learnMoreText = String(localized: " Learn more")
  }

  @Binding public var isEnabled: Bool

  var body: some View {
    VStack {
      Toggle(
        isOn: $isEnabled,
        label: {
          Text(LocalizedString.readReceiptsOptionTitle)
        }
      )
      .padding(.trailing, LayoutConstant.toggleTrailingPadding)
      .padding(.top, LayoutConstant.toggleTopPadding)

      HStack {
        Text(LocalizedString.readReceiptsOptionCaption)
          .font(.caption2)
          .foregroundStyle(Color(.gray))
          + Text(LocalizedString.learnMoreText)
          .font(.caption2)
          .foregroundStyle(Color(.blue))

        Spacer()
      }
    }
    .padding(.horizontal)
  }
}

#Preview {
  MessagesSettingsHomeReadReceiptsSectionView(isEnabled: .constant(true))
}
