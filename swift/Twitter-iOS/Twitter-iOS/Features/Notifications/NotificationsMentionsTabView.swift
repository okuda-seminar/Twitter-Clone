import SwiftUI

struct NotificationsMentionsTabView: View {

  private enum LocalizedString {
    static let headlineText = String(localized: "Join the conversation")
    static let subHeadlineText = String(
      localized: "When someone on Twitter mentions you in a post or reply, you'll find it here.")
  }

  var body: some View {
    VStack(
      alignment: .leading, spacing: 10,
      content: {
        Text(LocalizedString.headlineText)
          .font(.system(size: 29, weight: .heavy))

        Text(LocalizedString.subHeadlineText)
          .font(.system(size: 15))
          .foregroundStyle(.gray)

        Spacer()
      }
    )
    .padding(.vertical, 50)
  }
}

#Preview {
  NotificationsMentionsTabView()
}
