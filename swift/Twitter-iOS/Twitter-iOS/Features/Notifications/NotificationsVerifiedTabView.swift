import SwiftUI

struct NotificationsVerifiedTabView: View {

  @Binding public var openSubscribeOptionsPage: Bool

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 29.0
    static let vStackSpacing: CGFloat = 5.0
    static let subscribeButtonHeight: CGFloat = 44.0
    static let subscribeButtonCornerRadius: CGFloat = 22.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Nothing to see here — yet")
    // \ is required to avoid unintended line breaks.
    static let firstSubHeadlineText = String(
      localized: """
        Likes, mentions, reports, and a whole lot more — when it comes from a verified account, \
        you'll find it here.
        """)
    static let learnMoreText = String(localized: "Learn More\n")
    static let secondSubHeadlineText = String(
      localized: """
        Not verified? Subscribe now to get a verified account and join other people in quality \
        conversations.
        """)
    static let subscribeButtonLabel = String(localized: "Subscribe")
  }

  var body: some View {
    VStack {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/278
      // - Change 'apple.logo' Image to Correct Image.
      Image(systemName: "apple.logo")
        .padding()

      VStack(alignment: .leading, spacing: LayoutConstant.vStackSpacing) {

        Text(LocalizedString.headlineText)
          .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

        HStack {
          Text(LocalizedString.firstSubHeadlineText)
            .font(.caption2)
            .foregroundStyle(Color(.gray))
            + Text(LocalizedString.learnMoreText)
            .font(.caption2)
            .underline()
        }

        Text(LocalizedString.secondSubHeadlineText)
          .font(.caption2)
          .foregroundStyle(Color(.gray))
      }
      .padding()

      Button(
        action: {
          openSubscribeOptionsPage.toggle()
        },
        label: {
          Spacer()
          Text(LocalizedString.subscribeButtonLabel)
            .underline()
            .foregroundStyle(.white)
            .padding()
          Spacer()
        }
      )
      .background(Color(.black))
      .frame(height: LayoutConstant.subscribeButtonHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.subscribeButtonCornerRadius))
      .padding(.leading)
      .padding(.bottom)
      .padding(.trailing)

      Spacer()

    }
  }
}

#Preview {
  NotificationsVerifiedTabView(openSubscribeOptionsPage: .constant(false))
}
