import Foundation

func createFakeTopicModel() -> TopicModel {
  return TopicModel(id: UUID(), category: "Technology", name: "iMac", numOfPosts: 1413)
}

@objc
class TopicModel: NSObject, Identifiable {
  let id: UUID
  let category: String
  let name: String
  let numOfPosts: Int

  init(id: UUID, category: String, name: String, numOfPosts: Int) {
    self.id = id
    self.category = category
    self.name = name
    self.numOfPosts = numOfPosts
  }
}
