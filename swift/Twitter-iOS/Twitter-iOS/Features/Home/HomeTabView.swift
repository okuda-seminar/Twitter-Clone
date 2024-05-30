import SwiftUI

struct HomeTabView: View {
  @State private var tweetModels: [TweetModel] = {
    var models: [TweetModel] = []
    for _ in 0..<20 {
      models.append(createFakeTweetModel())
    }
    return models
  }()

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(tweetModels) { tweetModel in
          TweetCellView(
            userIcon: tweetModel.userIcon, userName: tweetModel.userName,
            tweetBody: tweetModel.bodyText)
        }
      }
    }
  }
}

#Preview {
  HomeTabView()
}
