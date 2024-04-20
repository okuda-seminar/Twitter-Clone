//
//  NewMessageEditView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/19.
//

import SwiftUI

struct NewMessageEditView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack {
      HStack {
        Button(
          action: {
            dismiss()
          },
          label: {
            Text(String(localized: "Cancel"))
              .underline()
              .foregroundStyle(Color.primary)
          })
        Spacer()
        Text(String(localized: "New message"))
          .font(.headline)
          .fontWeight(.bold)
        Spacer()
      }
      Divider()
      HStack {
        Text(String(localized: "To:"))
        Spacer()
      }
      Divider()
      HStack {
        Button(
          action: {

          },
          label: {
            Image(systemName: "person.3")
              .frame(width: 44, height: 44)
              .clipShape(Circle())
              .overlay(
                Circle()
                  .stroke(Color.blue)
              )
          })

        Button(
          action: {

          },
          label: {
            Text(String(localized: "Create a group"))
          })

        Spacer()
      }
      Divider()
      Spacer()
    }
    .padding(EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 0))
  }
}

#Preview{
  NewMessageEditView()
}
