import SwiftUI

struct MessagesSettingsHomeEnableCallingSectionView: View {
  private enum LayoutConstant {
    static let toggleTrailingPadding: CGFloat = 2.0
    static let toggleTopPadding: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let mediaOptionTitle = String(localized: "Enable audio and video calling")
    static let mediaOptionCaption = String(
      localized:
        "Take messaging to the next level with audio and video calls. When enabled you can select who you're comfortable using it with."
    )
    static let learnMoreText = String(localized: " Learn more")
  }

  @Binding public var isEnabled: Bool

  var body: some View {
    VStack {
      Toggle(
        isOn: $isEnabled,
        label: {
          Text(LocalizedString.mediaOptionTitle)
        }
      )
      .padding(.trailing, LayoutConstant.toggleTrailingPadding)
      .padding(.top, LayoutConstant.toggleTopPadding)

      HStack {
        Text(LocalizedString.mediaOptionCaption)
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
  MessagesSettingsHomeEnableCallingSectionView(isEnabled: .constant(true))
}
