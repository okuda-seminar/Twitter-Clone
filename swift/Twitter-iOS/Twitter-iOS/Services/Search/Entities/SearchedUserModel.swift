import Foundation
import UIKit

struct SearchedUserModel: Identifiable {
  let id: UUID
  let icon: UIImage?
  let name: String
  let userName: String

  public init(
    id: UUID, icon: UIImage?, name: String, userName: String
  ) {
    self.id = id
    self.icon = icon
    self.name = name
    self.userName = userName
  }
}

func createFakeSearchedUserModel() -> SearchedUserModel {
  return SearchedUserModel(
    id: UUID(), icon: UIImage(systemName: "shared.with.you"), name: "Name", userName: "@user_name")
}
