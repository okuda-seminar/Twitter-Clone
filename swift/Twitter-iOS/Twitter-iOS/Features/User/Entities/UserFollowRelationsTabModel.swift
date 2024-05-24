import SwiftUI

struct UserFollowRelationsTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case verifiedFollowers = "Verified Followers"
    case followers = "Followers"
    case following = "Following"
  }
}
