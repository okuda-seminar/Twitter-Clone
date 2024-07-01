import Foundation

struct HomeTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case forYou = "For You"
    case following = "Following"
  }
}
