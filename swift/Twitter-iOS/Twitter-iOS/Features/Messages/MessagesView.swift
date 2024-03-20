//
//  MessagesView.swift
//  Twitter-iOS
//

import SwiftUI

struct MessagesView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text(String(localized: "Welcome to your inbox!"))
        .font(.title)
        .fontWeight(.bold)
      Text(String(localized: "Drop a line, share posts and more with private conversations between you and others on X."))
        .font(.body)
        .fontWeight(.light)
        .foregroundStyle(Color.gray)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0))
      CapsuleNewMessageEntrypointButton()
      Spacer()
      HStack {
        Spacer()
        CircleNewMessageEntrypointButton()
      }
    }
    .padding()
  }
}

#Preview {
  MessagesView()
}
