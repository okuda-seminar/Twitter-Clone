import SwiftUI

struct PostModel: Identifiable {
  let id: UUID
  let bodyText: String
  let userIcon: UIImage
  let userName: String
  let isRepostedByCurrentUser: Bool
}

func createFakePostModel() -> PostModel {
  return PostModel(
    id: UUID(),
    bodyText:
      """
      Use a binding to create a two-way connection between a property that stores data,
      and a view that displays and changes the data. [Wikipedia](https://www.wikipedia.org)
      """,
    userIcon: UIImage(systemName: "apple.logo")!,  // Safe to unwrap
    userName: "Apple",
    isRepostedByCurrentUser: false
  )
}
