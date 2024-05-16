//

import SwiftUI

struct NotificationsSettingsView: View {
  @Environment(\.dismiss) private var dismiss

  private enum LocalizedString {
    static let navigationTitle = String(localized: "Notifications")
    static let dismissButtonTitle = String(localized: "Done")

    static let headerCaption = String(
      localized:
        "Select the kinds of notifications you get about your activities, interests, and recommendations."
    )

    static let filtersTitle = String(localized: "Filters")
    static let filtersCaption = String(
      localized: "Choose the notifications you'd like to see - and those you don't.")

    static let preferencesTitle = String(localized: "Preferences")
    static let preferencesCaption = String(
      localized: "Select your preferences by notification type.")
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          NotificationsStackItem(
            icon: Image(systemName: "line.3.horizontal.decrease.circle"),
            title: LocalizedString.filtersTitle, caption: LocalizedString.filtersCaption)

          NotificationsStackItem(
            icon: Image(systemName: "airport.express"), title: LocalizedString.preferencesTitle,
            caption: LocalizedString.preferencesCaption)
        }
        .navigationTitle(LocalizedString.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button(
              action: {
                dismiss()
              },
              label: {
                Image(systemName: "arrow.left")
                  .foregroundStyle(.black)
              })
          }

          ToolbarItem(placement: .topBarTrailing) {
            Button(
              action: {
                // Need to dismiss the sheet itself, not just go back.
                dismiss()
              },
              label: {
                Text(LocalizedString.dismissButtonTitle)
                  .underline()
                  .foregroundStyle(.black)
              })
          }
        }
      }
    }
  }
}

/// Probably we can create a shared stack item.
struct NotificationsStackItem: View {
  public var icon: Image?
  public var title: String
  public var caption: String

  var body: some View {
    Button(
      action: {},
      label: {
        HStack(alignment: .center) {
          icon
            .foregroundStyle(Color(uiColor: .gray))

          VStack(alignment: .leading) {
            Text(title)
              .foregroundStyle(.black)
              .font(.title3)
            Text(caption)
              .foregroundStyle(Color(uiColor: .brandedLightGrayText))
              .font(.caption2)
              .multilineTextAlignment(.leading)
          }
          .padding()

          Spacer()

          Image(systemName: "chevron.right")
            .foregroundStyle(Color(uiColor: .lightGray))
        }
        .padding()
      })
  }
}

#Preview{
  NotificationsSettingsView()
}
