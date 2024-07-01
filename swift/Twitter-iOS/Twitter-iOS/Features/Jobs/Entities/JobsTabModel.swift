import Foundation

struct JobsTabModel: Identifiable {
  private(set) var id: Tab

  enum Tab: String, CaseIterable {
    case search = "Search"
    case saved = "Saved"
  }
}
