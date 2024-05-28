import SwiftUI

struct SearchTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case forYou = "ForYou"
    case trending = "Trending"
    case news = "News"
    case sports = "Sports"
    case entertainment = "Entertainment"
  }
}
