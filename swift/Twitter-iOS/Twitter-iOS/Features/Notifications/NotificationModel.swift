//
//  File.swift
//  Twitter-iOS
//

import SwiftUI

func createFakeNotification() -> NotificationModel {
  return NotificationModel(
    id: UUID(),
    icon: Image(systemName: "person.circle"),
    message: "There was a login to your account.")
}

struct NotificationModel: Identifiable {
  let id: UUID
  let icon: Image
  let message: String
}
