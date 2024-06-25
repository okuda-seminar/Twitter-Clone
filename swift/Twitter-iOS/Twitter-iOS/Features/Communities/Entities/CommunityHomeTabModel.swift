import Foundation

struct CommunityHomeTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case myCommunity = "My Community"
    case explore = "Explore"
  }
}
