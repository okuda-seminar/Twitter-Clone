//
//  TweetCellView.swift
//  Twitter-iOS
//

import SwiftUI

func createFakeTweet() -> TweetModel {
  return TweetModel(
    id: UUID(),
    bodyText: "Use a binding to create a two-way connection between a property that stores data, and a view that displays and changes the data. ",
    userIcon: Image(systemName: "apple.logo"),
    userName: "Apple")
}

private  let fakeTweet = createFakeTweet()

struct TweetCellView: View {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/23 - Polish tweet cell view UI.
  var userIcon: Image
  var userName: String
  var bodyText: String

  var body: some View {
    HStack(alignment: .top) {
      userIcon
      VStack(alignment: .leading) {
        Text(userName)
          .font(.headline)
        Text(bodyText)
          .font(.body)
      }
    }
  }
}

#Preview {
  TweetCellView(userIcon: fakeTweet.userIcon, userName: fakeTweet.userName, bodyText: fakeTweet.bodyText)
}
