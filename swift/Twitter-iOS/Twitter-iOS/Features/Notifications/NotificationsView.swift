//
//  NotificationsView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/16.
//

import SwiftUI

struct NotificationsView: View {
  private let fakeNotifications: [NotificationModel] = {
    var notifications: [NotificationModel] = []
    for _ in 0..<30 {
      notifications.append(createFakeNotification())
    }
    return notifications
  }()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(fakeNotifications) { notification in
          NotificationCellView(notification: notification)
        }
      }
    }
  }
}

#Preview {
  NotificationsView()
}
