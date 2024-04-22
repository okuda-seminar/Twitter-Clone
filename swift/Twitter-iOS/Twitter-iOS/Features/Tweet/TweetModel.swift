import SwiftUI

struct TweetModel: Identifiable {
  let id: UUID
  let bodyText: String
  let userIcon: UIImage?
  let userName: String
}

func createFakeTweet() -> TweetModel {
  return TweetModel(
    id: UUID(),
    bodyText:
      "Use a binding to create a two-way connection between a property that stores data, and a view that displays and changes the data. ",
    userIcon: UIImage(systemName: "apple.logo"),
    userName: "Apple")
}
