import SwiftUI

struct MessagesSettingsHomeRelayCallsControlSectionView: View {

  private enum LayoutConstant {
    static let toggleTrailingPadding: CGFloat = 2.0
    static let toggleTopPadding: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let relayCallsOptionTitle = String(localized: "Always relay calls")
    static let relayCallsOptionCaption = String(
      localized:
        "Enable this setting to avoid revealing your IP address to your contact during the call. This will reduce call quality."
    )
  }

  @Binding public var isEnabled: Bool

  var body: some View {
    VStack {
      Toggle(
        isOn: $isEnabled,
        label: {
          Text(LocalizedString.relayCallsOptionTitle)
        }
      )
      .padding(.trailing, LayoutConstant.toggleTrailingPadding)
      .padding(.top, LayoutConstant.toggleTopPadding)

      HStack {
        Text(LocalizedString.relayCallsOptionCaption)
          .font(.caption2)
          .foregroundStyle(Color(.gray))

        Spacer()
      }
    }
    .padding(.horizontal)
  }
}

#Preview {
  MessagesSettingsHomeRelayCallsControlSectionView(isEnabled: .constant(true))
}
