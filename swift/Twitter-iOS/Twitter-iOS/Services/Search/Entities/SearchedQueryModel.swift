import Foundation

struct SearchedQueryModel: Identifiable {
  let id: UUID
  let text: String

  public init(id: UUID, text: String) {
    self.id = id
    self.text = text
  }
}

func createFakeSearchedQueryModel() -> SearchedQueryModel {
  return SearchedQueryModel(id: UUID(), text: "Fake search query")
}
