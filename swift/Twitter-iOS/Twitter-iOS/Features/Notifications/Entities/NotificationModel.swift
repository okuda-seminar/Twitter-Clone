import SwiftUI

struct NotificationModel: Identifiable {
  let id: UUID
  let userIcon: Image
  let userName: String
  let caption: String
}

func createFakeNotificationModel() -> NotificationModel {
  return NotificationModel(
    id: UUID(), userIcon: Image(systemName: "apple.logo"), userName: "Apple",
    caption: "Hello Apple!")
}
