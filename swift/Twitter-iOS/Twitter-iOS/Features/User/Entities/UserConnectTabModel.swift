import SwiftUI

struct CommunitiesConnectTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case whoToFollow = "Who to follow"
    case creatorsForYou = "Creators for you"
  }
}
