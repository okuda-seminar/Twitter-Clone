import SwiftUI

func createFakeCommunityFilterModel() -> CommunityFilterModel {
  return CommunityFilterModel(
    id: UUID(),
    name: "Sports"
  )
}

struct CommunityFilterModel: Identifiable {
  let id: UUID
  let name: String
}
