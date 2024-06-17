import SwiftUI

struct MessagesSettingsHomeMessageFilteringSectionView: View {
  private enum LayoutConstant {
    static let toggleTrailingPadding: CGFloat = 2.0
    static let toggleTopPadding: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let filterQualityOptionTitle = String(localized: "Filter low-quality messages")
    static let filterQualityOptionCaption = String(
      localized:
        "Hide message requests that have been detected as being potentially spam or low-quality. These will be sent to a separate inbox located at the bottom of your message requests. You can still access them if you want."
    )
    static let learnMoreText = String(localized: " Learn more")
  }

  @Binding public var isEnabled: Bool

  var body: some View {
    VStack {
      Toggle(
        isOn: $isEnabled,
        label: {
          Text(LocalizedString.filterQualityOptionTitle)
        }
      )
      .padding(.trailing, LayoutConstant.toggleTrailingPadding)
      .padding(.top, LayoutConstant.toggleTopPadding)

      HStack {
        Text(LocalizedString.filterQualityOptionCaption)
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
  MessagesSettingsHomeMessageFilteringSectionView(isEnabled: .constant(true))
}
