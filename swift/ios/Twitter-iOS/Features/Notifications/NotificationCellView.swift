//
//  NotificationCellView.swift
//  Twitter-iOS
//

import SwiftUI

struct NotificationCellView: View {
  var notification: NotificationModel

  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        notification.icon
        Text(notification.message)
      }
    }
    Divider()
  }
}

#Preview {
  NotificationCellView(notification: createFakeNotification())
}
