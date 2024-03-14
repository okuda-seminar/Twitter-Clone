//
//  TweetCellView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/10.
//

import SwiftUI

let fakeTweet = Tweet(bodyText: "Use a binding to create a two-way connection between a property that stores data, and a view that displays and changes the data. ", userIcon: Image(systemName: "apple.logo"), userName: "Apple")

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
