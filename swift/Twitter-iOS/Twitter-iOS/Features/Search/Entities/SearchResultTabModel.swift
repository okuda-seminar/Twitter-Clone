import SwiftUI

struct SearchResultTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case top = "Top"
    case latest = "Latest"
    case people = "People"
    case photos = "Photos"
    case videos = "Videos"
  }
}
