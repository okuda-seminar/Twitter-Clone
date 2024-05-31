import SwiftUI

struct NotificationsMentionsTabView: View {

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 29.0
    static let subHeadlineFontSize: CGFloat = 15.0
    static let headlineViewSpacing: CGFloat = 10.0
    static let headlineViewVerticalPadding: CGFloat = 50.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Join the conversation")
    static let subHeadlineText = String(
      localized: "When someone on Twitter mentions you in a post or reply, you'll find it here.")
  }

  var body: some View {
    VStack(
      alignment: .leading, spacing: LayoutConstant.headlineViewSpacing,
      content: {
        Text(LocalizedString.headlineText)
          .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

        Text(LocalizedString.subHeadlineText)
          .font(.system(size: LayoutConstant.subHeadlineFontSize))
          .foregroundStyle(.gray)

        Spacer()
      }
    )
    .padding(.vertical, LayoutConstant.headlineViewVerticalPadding)
  }
}

#Preview {
  NotificationsMentionsTabView()
}
