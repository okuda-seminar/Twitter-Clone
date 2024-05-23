import SwiftUI

func createFakeCommunityModel() -> CommunityModel {
  var topIcons: [Image] = []
  for _ in 0..<5 {
    topIcons.append(Image(systemName: "appletv"))
  }

  return CommunityModel(
    id: UUID(),
    image: Image(systemName: "apple.logo"),
    name: "Apple",
    topic: "Technology",
    topIcons: topIcons,
    roughNumOfMembers: "218K"
  )
}

struct CommunityModel: Identifiable {
  let id: UUID
  let image: Image
  let name: String
  let topic: String
  let topIcons: [Image]
  let roughNumOfMembers: String
}
