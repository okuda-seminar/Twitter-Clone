import SwiftUI

struct TweetModel: Identifiable {
  let id: UUID
  let bodyText: String
  let userIcon: Image
  let userName: String
}

func createFakeTweetModel() -> TweetModel {
  return TweetModel(
    id: UUID(),
    bodyText:
      "Use a binding to create a two-way connection between a property that stores data, and a view that displays and changes the data. ",
    userIcon: Image(systemName: "apple.logo"),
    userName: "Apple")
}
