//
//  SearchSettingsView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchSettingsView: View {
  @Environment(\.dismiss) private var dismiss
  @State var showNearContents = true

  var body: some View {
    VStack {
      HStack {
        Spacer()

        VStack {
          Text(String(localized: "Explore settings"))
            .font(.headline)
          Text("@fakeUserId")
        }

        Spacer()

        Button(
          action: {
            dismiss()
          },
          label: {
            Text(String(localized: "Done"))
              .foregroundStyle(Color.primary)
              .underline()
          })
      }

      HStack {
        Text(String(localized: "Location"))
          .font(.headline)
        Spacer()
      }

      HStack {
        Text(String(localized: "Show content in your current location"))
          .font(.body)

        Toggle(isOn: $showNearContents, label: {})
      }
      HStack {
        Text(
          String(localized: "When this is open, you'll see what's happenning around you right-now.")
        )
        .font(.caption)
        Spacer()
      }

      Spacer()
    }
    .padding()
  }
}

#Preview {
  SearchSettingsView()
}
