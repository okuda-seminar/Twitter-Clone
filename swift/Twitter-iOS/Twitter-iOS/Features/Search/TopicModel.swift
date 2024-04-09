import Foundation

func createFakeTopicModel() -> TopicModel {
  return TopicModel(id: UUID(), category: "Technology", name: "iMac", numOfPosts: 1413)
}

struct TopicModel: Identifiable {
  let id: UUID
  let category: String
  let name: String
  let numOfPosts: Int
}
