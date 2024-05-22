import SwiftUI

struct UserProfileTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case posts = "Posts"
    case replies = "Replies"
    case highlights = "Highlights"
    case media = "Media"
    case likes = "Likes"
  }
}
