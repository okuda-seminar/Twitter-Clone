import SwiftUI

struct NotificationsTabModel: Identifiable {
  private(set) var id: Tab
  var size: CGSize = .zero
  var minX: CGFloat = .zero

  enum Tab: String, CaseIterable {
    case all = "All"
    case verified = "Verified"
    case mentions = "Mentions"
  }
}
