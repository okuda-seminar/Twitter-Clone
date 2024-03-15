//
//  ForYouTabView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/10.
//

import SwiftUI

struct ForYouTabView: View {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/26 - Fetch tweet data from backend.
  private let fakeTweets: [Tweet] = {
    var tweets: [Tweet] = []
    for _ in 0..<30 {
      tweets.append(createFakeTweet())
    }
    return tweets
  }()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(fakeTweets) { fakeTweet in
          Divider()
          TweetCellView(userIcon: fakeTweet.userIcon, userName: fakeTweet.userName, bodyText: fakeTweet.bodyText)
        }
      }
    }
    .background(Color(UIColor.systemBackground))
  }
}

#Preview {
  ForYouTabView()
}
